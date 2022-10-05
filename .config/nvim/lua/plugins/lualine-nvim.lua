local function location()
  return [[%04l:%04c:%04L]]
end

local theme = require 'lualine.themes.kanagawa'
-- local theme = require 'lualine.themes.github'
-- theme.inactive.a.fg = '#23d18b' -- green
-- theme.inactive.b.fg = '#23d18b' -- green
-- theme.inactive.c.fg = '#23d18b' -- green

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = { 'toggleterm', 'help', 'man' },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'hostname',
      'branch',
      {
        'diagnostics',
        update_in_insert = true,
        always_visible = true,
        cond = vim.lsp.buf.server_ready,
      },
    },
    lualine_c = {
      'diff',
      { 'filename', file_status = true, path = 1 },
      { "require'nvim-navic'.get_location()", cond = require('nvim-navic').is_available },
    },
    lualine_x = { { "require'goldsmith'.status()" }, 'lsp_progress', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {
    lualine_a = {},
    lualine_b = {},
  },
  inactive_winbar = {
    lualine_y = { 'branch' },
    lualine_z = { { 'filename', path = 1 } },
  },
  extensions = { 'fugitive' },
}
