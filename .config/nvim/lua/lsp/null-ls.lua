local null = require 'null-ls'
local help = require 'null-ls.helpers'
local u = require 'null-ls.utils'
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics
local act = null.builtins.code_actions

null.register {
  name = 'perlimports',
  method = null.methods.FORMATTING,
  filetypes = { 'perl' },
  generator = help.formatter_factory {
    command = 'perlimports',
    to_stdin = true,
    args = { '--read-stdin', '--filename', '$FILENAME' },
    timeout = 10000, -- this can take a long time
  },
}

-- root dirs
local function match_root_dir(...)
  local f = u.root_pattern(..., 'Makefile', '.git')
  return function(params)
    return f(params.root)
  end
end
local lua_root = match_root_dir('selene.toml', 'stylua.toml')

return {
  log_level = 'debug',
  sources = {
    fmt.stylua,
    fmt.perltidy.with {
      extra_args = function(params)
        local m = string.match(params.cwd, '^(.*/work)')
        if m then
          return { string.format('-pro=%s/mm_website/.perltidyallrc', m) }
        end
      end,
    },
    fmt.prettier.with {
      extra_args = function(params)
        local m = string.match(params.cwd, '^(.*/work)')
        if m then
          return { '--config', string.format('%s/mm_website/.prettierrc', m) }
        end
      end,
    },
    diag.markdownlint.with {
      extra_args = function(params)
        return { '--config', '~/.markdownlint.jsonc' }
      end,
    },
    diag.codespell,
    fmt.shfmt.with { args = { '-i=4', '-ci', '-s', '-bn' } },
    diag.selene.with { cwd = lua_root },
    -- diag.luacheck.with {
    --   args = {
    --     '--globals',
    --     'vim',
    --     '--formatter',
    --     'plain',
    --     '--max-line-length',
    --     '140',
    --     '--codes',
    --     '--ranges',
    --     '--filename',
    --     '$FILENAME',
    --     '-',
    --   },
    -- },
    diag.editorconfig_checker.with {
      command = 'editorconfig-checker',
      filetypes = { 'go', 'gomod', 'lua', 'json', 'sh', 'make', 'vim' },
    },
    diag.vint,
    fmt.shellharden,
    -- shellcheck is used by bash-language-server
    -- diag.shellcheck,
    -- very noisy
    -- act.gitsigns.with { disabled_filetypes = { 'man' } },
  },
}
