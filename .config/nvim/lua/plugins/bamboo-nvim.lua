require('bamboo').setup {
  style = 'multiplex',
  -- Main options --
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'italic',
    functions = 'bold',
    strings = 'none',
    variables = 'italic',
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {
    black = '#000000',
    bg0 = '#000000',
  }, -- Override default colors
  highlights = {
    ['@comment'] = { fg = '$grey' },
  }, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = false, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
require('bamboo').load()
