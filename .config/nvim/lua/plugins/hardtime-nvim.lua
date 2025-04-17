-- https://github.com/m4xshen/hardtime.nvim
local config = require('hardtime.config').config
config['restricted_keys']['-'] = nil
vim.list_extend(config.disabled_filetypes, { 'wiki', 'godoc', 'man', 'outputpanel', 'json' })
require('hardtime').setup {
  max_count = 4,
}
