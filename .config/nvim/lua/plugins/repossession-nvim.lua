require('repossession').setup {
  auto = true,
  continuous_save = true,
  blacklist_dirs = vim.tbl_flatten {
    '~',
    '~/bin',
    '~/.bash-init',
    '~/tmp',
    '~/.config/nvim',
    '~/.config/nvim/lua',
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
}
