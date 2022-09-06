local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
  'n',
  'n',
  [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  'n',
  'N',
  [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap('n', '*', [[<cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[<cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[<cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[<cmd>lua require('hlslens').start()<CR>]], kopts)

-- vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', kopts)

require('hlslens').setup {
  auto_enable = true,
  enable_incsearch = true,
  calm_down = false,
  nearest_only = true,
  nearest_float_when = 'auto',
  float_shadow_blend = 50,
  virt_priority = 100,
  override_lens = nil,
}
