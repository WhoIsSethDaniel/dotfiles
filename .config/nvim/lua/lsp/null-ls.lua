local null = require 'null-ls'
local help = require 'null-ls.helpers'
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics

null.register {
  name = 'perlimports',
  method = null.methods.FORMATTING,
  filetypes = { 'perl' },
  generator = help.formatter_factory {
    command = 'perlimports',
    to_stdin = true,
    args = { '--read-stdin', '--cache', '--filename', '$FILENAME' },
  },
}

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
