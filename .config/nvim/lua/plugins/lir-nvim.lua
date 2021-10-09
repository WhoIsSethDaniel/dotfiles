vim.api.nvim_set_keymap('n', '-', '<cmd>edit .<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '_', '<cmd>execute "edit " fnameescape(expand(\'%:p:h\'))<cr>', { noremap = true })

local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'

require('lir').setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['<cr>'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['-'] = actions.up,
    ['q'] = actions.quit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! j'
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {},
  hide_cursor = true,
}
