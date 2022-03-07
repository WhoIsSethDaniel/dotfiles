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
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.bufhidden = 'wipe'
  end,
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

-- toggleterm takes care of most things terminal related
group = 'terminal_settings'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  group = group,
  callback = function()
    require('functions').terminal_open_setup()
  end,
})

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
    vim.cmd [[ TSUpdate ]]
  end,
})

-- mark git buffers as wipe/delete on close
group = 'neovim_remote'
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  callback = function()
    vim.opt_local.bufhidden = 'delete'
  end,
})
