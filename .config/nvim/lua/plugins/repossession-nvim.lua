require('repossession').setup {
  auto = true,
  ignore_ft = { 'gitcommit', 'gitrebase', 'gitconfig' },
  -- blacklist_dirs = function()
  --   return vim.tbl_flatten {
  --     '~',
  --     '~/bin',
  --     '~/.bash-init',
  --     '~/tmp',
  --     '~/.config/nvim',
  --     '~/.config/nvim/lua',
  --     '~/src',
  --     '~/src/site',
  --     '~/.config/nvim/lua/**',
  --     '~/src/site/**',
  --     '~/.local/share/nvim/**',
  --     vim.tbl_filter(function(f)
  --       if string.match(f, 'dotfiles/home/') then
  --         return false
  --       end
  --       return vim.fn.isdirectory(f) > 0 and true or false
  --     end, vim.fn.glob('~/.config/dotfiles/**', false, true)),
  --   }
  -- end,
}

vim.keymap.set('n', '<leader>ss', function()
  require('repossession.telescope').sessions()
end, { silent = true })
