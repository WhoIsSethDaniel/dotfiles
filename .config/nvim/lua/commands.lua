vim.api.nvim_command [[ command! -nargs=0 LoadAll :args `fdfind --type f --exclude .git -c never -H`<cr> ]]
