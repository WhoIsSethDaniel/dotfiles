require('github-theme').setup {
  theme_style = 'dark',
  keyword_style = 'bold',
  hide_inactive_statusline = false,
  sidebars = { 'qf' },
  dark_float = false,
  -- colors = { bg = '#000000', line_nr = '#008800' }
  colors = { bg = '#000000' },
}

vim.cmd [[ colorscheme github_dark ]]
