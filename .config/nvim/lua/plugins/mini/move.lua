-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-move.md
require('mini.move').setup {
  mappings = {
    -- Move visual selection in Visual mode.
    left = '<C-h>',
    right = '<C-l>',
    down = '<C-j>',
    up = '<C-k>',

    -- Move current line in Normal mode
    line_left = '<C-h>',
    line_right = '<C-l>',
    line_down = '<C-j>',
    line_up = '<C-k>',
  },
}
