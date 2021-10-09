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
augroup END
]],
  false
)

-- normalize windows when a new one opens / closes
-- vim.api.nvim_exec(
--   [[
-- augroup on_window_event
--     autocmd!
--     autocmd WinNew,WinEnter,WinClosed * wincmd =
-- augroup END
-- ]],
--   false
-- )
