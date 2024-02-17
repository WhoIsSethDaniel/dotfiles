vim.g.wiki_root = '/home/seth/.config/dotfiles/main/notes'
vim.g.wiki_filetypes = { 'wiki' }
vim.g.wiki_link_extension = '.wiki'

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.wiki' },
  command = 'set filetype=wiki',
})
