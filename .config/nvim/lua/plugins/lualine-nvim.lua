local function location()
  return [[%04l:%04c:%04L]]
end

local theme = require 'lualine.themes.kanagawa'
-- local theme = require 'lualine.themes.github'
-- theme.inactive.a.fg = '#23d18b' -- green
-- theme.inactive.b.fg = '#23d18b' -- green
-- theme.inactive.c.fg = '#23d18b' -- green

require('lualine').setup {
  options = { theme = theme, section_separators = '', component_separators = '', icons_enabled = true },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'hostname', 'branch' },
    lualine_c = {
      'diff',
      { 'filename', file_status = true, path = 1 },
      { "require'nvim-gps'.get_location()", cond = require'nvim-gps'.is_available },
      { "require'lsp-status'.status()" },
      { "require'goldsmith'.status()" },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { location },
  },
  extensions = { 'fugitive' },
}
