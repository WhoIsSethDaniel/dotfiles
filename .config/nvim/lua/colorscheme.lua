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

require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords 
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    colors = { bg = '#000000' },
    overrides = {},
})

vim.cmd [[ colorscheme kanagawa ]]
