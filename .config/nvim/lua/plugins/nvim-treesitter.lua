--  https://github.com/nvim-treesitter/nvim-treesitter
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('StartupBufRead', { clear = true }),
  callback = function()
    ---@diagnostic disable-next-line:missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = 'all',
      -- ignore_install = { 'cooklang' },
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
      matchup = {
        enable = true,
      },
    }
  end,
})

-- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
-- parser_config.perl = {
--   install_info = {
--     url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
--     revision = 'release',
--     files = { 'src/parser.c', 'src/scanner.c' },
--     -- generate_requires_npm = true,
--   },
--   maintainers = { '@leonerd' },
--   filetype = 'perl',
-- }

-- parser_config.gotmpl = {
--   install_info = {
--     url = "https://github.com/ngalaiko/tree-sitter-go-template",
--     files = {"src/parser.c"},
--   },
--   filetype = "gotmpl",
--   used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl"},
-- }
