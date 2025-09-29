local mb = require 'messages-buffer'
mb.setup {
  win_cmd = 'rightbelow 120vsplit',
}

vim.keymap.set('n', '<leader>mm', mb.toggle, { noremap = true, silent = true })
