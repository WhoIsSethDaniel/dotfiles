-- https://github.com/m4xshen/hardtime.nvim
local config = require('hardtime').setup {
  restricted_keys = nil,
  disabled_filetypes = { 'wiki', 'godoc', 'man', 'outputpanel', 'json' },
  max_count = 4,
}
