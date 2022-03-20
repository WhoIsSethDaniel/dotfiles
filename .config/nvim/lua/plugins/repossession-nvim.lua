require('repossession').setup {
  auto_load = true,
  auto_save = true,
  continuous_save = true,
  blacklist_dirs = vim.tbl_map(
    function(d)
      return vim.fn.expand(d)
    end,
    vim.tbl_flatten {
      '~',
      '~/.bash-init',
      '~/tmp',
      '~/.config/nvim',
      '~/.config/nvim/lua',
      '~/src/site',
      vim.tbl_filter(function(f)
        if string.match(f, 'dotfiles/home/') then
          return false
        end
        return vim.fn.isdirectory(f) > 0 and true or false
      end, vim.fn.glob('~/.config/dotfiles/**', false, true)),
      vim.tbl_filter(function(f)
        return vim.fn.isdirectory(f) > 0 and true or false
      end, vim.fn.glob('~/.config/nvim/lua/**', false, true)),
      vim.tbl_filter(function(f)
        return vim.fn.isdirectory(f) > 0 and true or false
      end, vim.fn.glob('~/src/site/**', false, true)),
    }
  ),
}
