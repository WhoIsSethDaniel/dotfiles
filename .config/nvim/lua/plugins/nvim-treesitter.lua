--  https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  ignore_install = { 'cooklang' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.perl = {
  install_info = {
    url = 'https://github.com/leonerd/tree-sitter-perl',
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
  },
  maintainers = { '@leonerd' },
  filetype = 'perl',
}

parser_config.http = {
  install_info = {
    url = 'https://github.com/NTBBloodbath/tree-sitter-http',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}
