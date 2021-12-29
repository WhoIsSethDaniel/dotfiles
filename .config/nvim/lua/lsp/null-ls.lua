local null = require 'null-ls'
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics

return {
  sources = {
    fmt.stylua,
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
    diag.editorconfig_checker.with { filetypes = { 'go', 'gomod' } },
    diag.vint,
    diag.shellcheck,
  },
}
