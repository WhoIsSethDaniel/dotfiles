vim.cmd [[
  augroup enable_lists
  autocmd!
  autocmd BufRead *.wiki,*.md ListsEnable
  augroup END
]]
