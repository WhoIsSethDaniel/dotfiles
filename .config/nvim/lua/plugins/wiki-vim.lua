vim.g.wiki_root = '/home/seth/.config/dotfiles/main/notes'
vim.g.wiki_filetypes = { 'wiki' }
vim.g.wiki_link_extension = '.wiki'
vim.api.nvim_exec(
  [[
    augroup init_wiki
    autocmd BufRead,BufNewFile *.wiki set filetype=wiki
    augroup END
]],
  false
)
