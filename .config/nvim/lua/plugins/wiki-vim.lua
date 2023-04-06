vim.g.wiki_root = '/home/seth/.config/dotfiles/main/notes'
vim.g.wiki_link_extension = 'wiki'
vim.g.wiki_file_handle = '.wiki'
vim.g.wiki_link_toggle_on_follow = 'wiki'
vim.api.nvim_exec(
  [[
    augroup init_wiki
    autocmd BufRead,BufNewFile *.wiki set filetype=markdown
    augroup END
]],
  false
)
