require('hybrid').setup {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    folds = true,
  },
  strikethrough = true,
  inverse = true,
  transparent = false,
  -- You can override specific highlights to use other groups or a hex color
  overrides = function(hl, c)
    local background = '#000000'
    hl.Normal = {
      fg = c.fg,
      bg = background,
    }
    hl.LineNr = {
      bg = background,
    }
    hl.SignColumn = {
      bg = background,
    }
  end,
}
vim.cmd.colorscheme 'hybrid'
