-- require('github-theme').setup {
--   theme_style = 'dark',
--   keyword_style = 'bold',
--   hide_inactive_statusline = false,
--   sidebars = { 'qf' },
--   dark_float = false,
--   -- colors = { bg = '#000000', line_nr = '#008800' }
--   colors = { bg = '#000000' },
-- }
--
-- vim.cmd [[ colorscheme github_dark ]]

require('kanagawa').setup {
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = false, -- do not set background color
  dimInactive = true, -- dim inactive window `:h hl-NormalNC`
  globalstatus = true,
  terminalColors = true,
  colors = { bg = '#000000' },
  overrides = {},
  theme = 'default',
}

vim.cmd [[ colorscheme kanagawa ]]
