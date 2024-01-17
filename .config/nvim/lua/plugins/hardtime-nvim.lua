local config = require('hardtime.config').config
config['restricted_keys']['-'] = nil
require('hardtime').setup(config)
