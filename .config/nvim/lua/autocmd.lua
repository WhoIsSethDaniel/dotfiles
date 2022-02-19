-- open certain things in a vertical split and set options for docs
vim.api.nvim_exec(
  [[
augroup doc_settings_and_win
  autocmd!
  autocmd FileType help,man wincmd L
  autocmd FileType lir,help,man setlocal nonumber norelativenumber signcolumn=no
  autocmd FileType lir,help,man setlocal bufhidden=wipe
augroup END
  ]],
  false
)

-- make neovim terminal act more like vim terminal
vim.api.nvim_exec(
  [[
augroup terminal_settings
  autocmd!
  " do not show line numbers; start in insert mode
  autocmd TermOpen * lua require'functions'.terminal_open_setup()
  autocmd BufEnter term://* startinsert
  " do not show "process exited 0" when exiting
  autocmd BufLeave term://* stopinsert
  autocmd TermClose term://*bash call nvim_input('<CR>')
augroup END
  ]],
  false
)

-- create missing directories when opening new files
vim.api.nvim_exec(
  [[
augroup create_missing_dirs
  autocmd!
  autocmd BufWritePre * lua require'functions'.create_missing_dirs()
augroup END
  ]],
  false
)

-- re-build help tag files on start
vim.api.nvim_exec(
  [[
augroup vim_on_start
  autocmd!
  autocmd VimEnter * lua require'functions'.rebuild_help()
  autocmd VimEnter * TSUpdate
augroup END
  ]],
  false
)

-- highlighted yank
vim.api.nvim_exec(
  [[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=500, on_visual=true})
augroup END
  ]],
  false
)

-- mark git buffers as wipe/delete on close
vim.api.nvim_exec(
  [[
augroup neovim_remote
  autocmd!
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END
  ]],
  false
)
