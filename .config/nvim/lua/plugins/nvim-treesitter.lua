--  https://github.com/nvim-treesitter/nvim-treesitter
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('StartupBufRead', { clear = true }),
  callback = function()
    ---@diagnostic disable-next-line:missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = 'all',
      -- ignore_install = { 'cooklang' },
      autopairs = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    }
  end,
})
