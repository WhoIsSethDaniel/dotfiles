-- open certain things in a vertical split and set options for docs
local group = 'doc_settings_and_win'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'help', 'man' },
  command = 'wincmd L',
})
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'lir', 'help', 'man' },
  command = 'setlocal nonumber norelativenumber signcolumn=no',
})
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'lir', 'help', 'man' },
  command = 'setlocal bufhidden=wipe',
})

-- highlighted yank
group = 'highlight_yank'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500, on_visual = true }
  end,
})

-- this is taken care of by toggleterm
-- make neovim terminal act more like vim terminal
-- group = 'terminal_settings'
-- vim.api.nvim_create_augroup(group, { clear = true })
-- vim.api.nvim_create_autocmd('TermOpen', {
--   group = group,
--   callback = function()
--     require('functions').terminal_open_setup()
--   end,
-- })
-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = group,
--   pattern = { 'term://*' },
--   command = 'startinsert',
-- })
-- vim.api.nvim_create_autocmd('BufLeave', {
--   group = group,
--   pattern = { 'term://*' },
--   command = 'stopinsert',
-- })
-- vim.api.nvim_create_autocmd('TermClose', {
--   group = group,
--   pattern = { 'term://*bash' },
--   callback = function()
--     vim.api.nvim_input '<CR>'
--   end,
-- })

-- create missing directories when opening new files
group = 'create_missing_dirs'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function()
    require('functions').create_missing_dirs()
  end,
})

-- re-build help tag files on start;
-- update treesitter parsers
group = 'vim_on_start'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  callback = function()
    require('functions').rebuild_help()
  end,
})
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  command = 'TSUpdate',
})

-- mark git buffers as wipe/delete on close
group = 'neovim_remote'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  command = 'setlocal bufhidden=delete',
})
