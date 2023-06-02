require('kanagawa').setup {
  compile = false,
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
  colors = {
    palette = {
      -- dragonBlack0 = '#000000',
      -- dragonBlack1 = '#000000',
      -- dragonBlack2 = '#000000',
      dragonBlack3 = '#000000',
      dragonBlack4 = '#000000',
      -- dragonBlack5 = '#000000',
      -- dragonBlack6 = '#000000',
    },
    theme = {
      all = {
        ui = {
          -- bg = 'veryBlack',
        },
      },
    },
  },
  -- overrides = function(colors) end,
  theme = 'dragon',
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
}

vim.cmd [[ colorscheme kanagawa ]]

-- require('bamboo').setup {
--   -- Main options --
--   transparent = false, -- Show/hide background
--   term_colors = true, -- Change terminal color as per the selected theme style
--   ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--   cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--   -- Change code style ---
--   -- Options are italic, bold, underline, none
--   -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--   code_style = {
--     comments = 'italic',
--     keywords = 'none',
--     functions = 'bold',
--     strings = 'none',
--     variables = 'none',
--   },
--
--   -- Lualine options --
--   lualine = {
--     transparent = false, -- lualine center bar transparency
--   },
--
--   -- Custom Highlights --
--   colors = {
--     black = '#000000',
--     bg0 = '#000000',
--   }, -- Override default colors
--   highlights = {}, -- Override highlight groups
--
--   -- Plugins Config --
--   diagnostics = {
--     darker = false, -- darker colors for diagnostic
--     undercurl = true, -- use undercurl instead of underline for diagnostics
--     background = true, -- use background color for virtual text
--   },
-- }
-- require('bamboo').load()
