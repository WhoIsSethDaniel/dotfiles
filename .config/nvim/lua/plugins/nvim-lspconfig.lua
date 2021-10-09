local i = require 'nvim-lsp-installer'

local function setup_servers()
  local servers = i.get_installed_servers()

  for _, server in pairs(servers) do
    if not require('goldsmith').needed(server) then
      local config = require('lsp').get_config(server.name)
      server:setup(config)
    end
  end
  require('lspconfig').perlpls.setup(require('lsp').get_config 'perlpls')
end

setup_servers()
