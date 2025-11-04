-- https://github.com/b0o/incline.nvim
local helpers = require 'incline.helpers'
local micons = require 'mini.icons'
local navic = require 'nvim-navic'
require('incline').setup {
  window = {
    padding = 0,
    margin = {
      horizontal = 0,
      vertical = 0,
    },
    placement = {
      horizontal = 'right',
      vertical = 'top',
    },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    local full_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':p:.')
    if filename == '' then
      filename = '[No Name]'
    end
    local ft_icon, hl_name, _ = micons.get('file', filename)
    local hl = vim.api.nvim_get_hl(0, { name = hl_name })
    local ft_color = string.format('#%06x', hl.fg)
    local modified = vim.bo[props.buf].modified
    local res = {
      ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
      ' ',
      { props.focused and filename or full_path, gui = modified and 'bold,italic' or 'bold' },
      guibg = '#44406e',
    }
    if props.focused then
      for _, item in ipairs(navic.get_data(props.buf) or {}) do
        table.insert(res, {
          { ' > ', group = 'NavicSeparator' },
          { item.icon, group = 'NavicIcons' .. item.type },
          { item.name, group = 'NavicText' },
        })
      end
    end
    table.insert(res, ' ')
    return res
  end,
}
