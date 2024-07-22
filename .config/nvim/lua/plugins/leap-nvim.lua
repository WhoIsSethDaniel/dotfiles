-- https://github.com/ggandor/leap.nvim
-- change 's' default to 'gs' so as not to conflict with vim-sandwich
vim.keymap.set('n', 'gs', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
vim.keymap.set({ 'x', 'o' }, 'gs', '<Plug>(leap-forward)')
vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)')
