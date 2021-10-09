local opts = {
  log_level = 'error',
  -- Root dir where sessions will be stored
  auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
  -- Enables/disables auto save/restore
  auto_session_enabled = true,
  auto_session_suppress_dirs = vim.fn.flatten {
    '~',
    '~/tmp',
    '~/.config/nvim',
    '~/.config/nvim/lua',
    '~/src/site',
    vim.fn.filter(vim.fn.glob('~/src/lgwt/**', false, true), 'isdirectory(v:val)'),
    vim.fn.filter(vim.fn.glob('~/.config/nvim/lua/**', false, true), 'isdirectory(v:val)'),
    vim.fn.filter(vim.fn.glob('~/src/site/**', false, true), 'isdirectory(v:val)'),
  },
}
require('auto-session').setup(opts)
