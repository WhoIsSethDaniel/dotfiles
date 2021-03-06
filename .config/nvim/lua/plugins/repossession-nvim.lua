require('repossession').setup {
  auto = true,
  ignore_ft = { 'gitcommit', 'gitrebase', 'gitconfig' },
  blacklist_dirs = vim.tbl_flatten {
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
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>ss',
  "<cmd>lua require'repossession.telescope'.sessions()<cr>",
  { noremap = true, silent = true }
)
