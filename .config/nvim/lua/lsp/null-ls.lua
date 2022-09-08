local null = require 'null-ls'
local help = require 'null-ls.helpers'
local u = require 'null-ls.utils'
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics
local act = null.builtins.code_actions

-- root dirs
local function match_root_dir(...)
  local f = u.root_pattern(..., 'Makefile', '.git')
  return function(params)
    -- use .bufname instead of .root
    return f(params.bufname)
  end
end
local lua_root = match_root_dir('selene.toml', 'stylua.toml')

-- config files
local function match_conf(...)
  local patterns = ...
  local f = u.root_pattern(...)
  return function(root)
    local d = f(root)
    for _, pattern in ipairs(vim.tbl_flatten { patterns }) do
      local c = string.format('%s/%s', d, pattern)
      if u.path.exists(c) then
        return c
      end
    end
  end
end

return {
  log_level = 'debug',
  sources = {
    -- diag.codespell,
    diag.editorconfig_checker.with {
      command = 'editorconfig-checker',
      filetypes = { 'go', 'gomod', 'lua', 'json', 'sh', 'make', 'vim' },
    },
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
    diag.markdownlint.with {
      extra_args = function(params)
        local c = match_conf '.markdownlint.jsonc'(params.root)
        return { '--config', c }
      end,
    },
    diag.selene.with { cwd = lua_root },
    -- shellcheck is used by bash-language-server
    -- diag.shellcheck,
    diag.sqlfluff.with { extra_args = { '--dialect', 'postgres' } },
    diag.vint,
    diag.yamllint,
    fmt.cbfmt.with {
      extra_args = function(params)
        local c = match_conf '.cbfmt.toml'(params.root)
        if c then
          return { '--config', c }
        end
      end,
    },
    fmt.perlimports,
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
    fmt.shellharden,
    fmt.shfmt.with { args = { '-i=4', '-ci', '-s', '-bn' } },
    fmt.sqlfluff.with { extra_args = { '--dialect', 'postgres' } },
    fmt.stylua,
    fmt.yamlfmt,
  },
}
