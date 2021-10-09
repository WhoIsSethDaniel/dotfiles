-- https://github.com/sumneko/lua-language-server
local config = require('lua-dev').setup()
config.settings.Lua.workspace.maxPreload = 100
config.settings.Lua.workspace.preloadFileSize = 30
return config
