local i = require 'nvim-lsp-installer'

local function setup_servers()
  local servers = i.get_installed_servers()

  for _, server in pairs(servers) do
    if not require('goldsmith').needed(server.name) then
      local config = require('lsp').get_config(server.name)
      server:setup(config)
    end
  end
end

setup_servers()

-- require'vim.lsp.log'.set_level(vim.log.levels.TRACE)
require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
-- require('vim.lsp.log').set_level(vim.log.levels.INFO)
require('vim.lsp.log').set_format_func(vim.inspect)
