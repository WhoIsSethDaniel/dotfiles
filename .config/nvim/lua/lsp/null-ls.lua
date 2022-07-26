local null = require 'null-ls'
local help = require 'null-ls.helpers'
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

return {
  sources = {
    fmt.stylua,
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
    diag.luacheck.with {
      args = {
        '--globals',
        'vim',
        '--formatter',
        'plain',
        '--max-line-length',
        '140',
        '--codes',
        '--ranges',
        '--filename',
        '$FILENAME',
        '-',
      },
    },
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
