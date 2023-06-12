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
