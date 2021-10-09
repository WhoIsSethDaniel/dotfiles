require'qf_helper'.setup({
  prefer_loclist = true,
  sort_lsp_diagnostics = true,
  quickfix = {
    autoclose = true,
    default_bindings = false,
    default_options = true,
    max_height = 10,
    min_height = 4,
    track_location = 'cursor',
  },
  loclist = {
    autoclose = true,
    default_bindings = false,
    default_options = true,
    max_height = 10,
    min_height = 4,
    track_location = 'cursor',
  },
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', ']q', '<cmd>QNext<cr>', opts)
vim.api.nvim_set_keymap('n', '[q', '<cmd>QPrev<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>QFToggle!<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>ll', '<cmd>LLToggle!<cr>', opts)
