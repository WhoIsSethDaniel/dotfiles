vim.g.wiki_root = '/home/seth/.config/dotfiles/main/notes'
vim.api.nvim_exec([[
    augroup init_wiki
    autocmd BufRead,BufNewFile *.wiki set filetype=markdown
    augroup END
]], false)
