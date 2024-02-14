-- https://github.com/m4xshen/hardtime.nvim
local config = require('hardtime.config').config
config['restricted_keys']['-'] = nil
require('hardtime').setup {
  max_count = 4,
  restricted_keys = {
    ['-'] = nil,
  },
}
