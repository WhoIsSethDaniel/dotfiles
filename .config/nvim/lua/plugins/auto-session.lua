require('repossession').setup {
  auto = true,
  ignore_ft = { 'gitcommit', 'gitrebase', 'gitconfig' },
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = vim.tbl_flatten {
    '~',
    '~/bin',
    '~/.bash-init',
    '~/tmp',
    '~/.config/nvim',
    '~/.config/nvim/lua',
    '~/src',
    '~/src/site',
    '~/.config/nvim/lua/**',
    '~/src/site/**',
    '~/.local/share/nvim/**',
    vim.tbl_filter(function(f)
      if string.match(f, 'dotfiles/home/') then
        return false
      end
      return vim.fn.isdirectory(f) > 0 and true or false
    end, vim.fn.glob('~/.config/dotfiles/**', false, true)),
  },
  auto_session_use_git_branch = true,
  bypass_session_save_file_types = nil,
  cwd_change_handling = {
    restore_upcoming_session = true,
  },
}

-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>ss',
--   "<cmd>lua require'repossession.telescope'.sessions()<cr>",
--   { noremap = true, silent = true }
-- )
