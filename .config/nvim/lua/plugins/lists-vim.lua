vim.api.nvim_create_autocmd('BufRead', {
  pattern = { '*.wiki', '*.md' },
  command = 'ListsEnable',
})
