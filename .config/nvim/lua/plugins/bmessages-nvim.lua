-- https://github.com/ariel-frischer/bmessages.nvim
require('bmessages').setup()
vim.api.nvim_set_keymap('n', '<leader>mm', '<cmd>Bmessages<cr><c-w>p', { noremap = true, silent = true })
