-- https://github.com/stevearc/qf_helper.nvim
require('qf_helper').setup {
  prefer_loclist = true,
  sort_lsp_diagnostics = true,
  quickfix = {
    autoclose = true,
    default_bindings = false,
    default_options = true,
    max_height = 10,
    min_height = 4,
    track_location = true,
  },
  loclist = {
    autoclose = true,
    default_bindings = false,
    default_options = true,
    max_height = 10,
    min_height = 4,
    track_location = true,
  },
}

vim.keymap.set('n', '<C-n>', '<cmd>QNext<cr>')
vim.keymap.set('n', '<C-p>', '<cmd>QPrev<cr>')
vim.keymap.set('n', '<leader>cl', '<cmd>QFToggle!<cr>')
vim.keymap.set('n', '<leader>ll', '<cmd>LLToggle!<cr>')
