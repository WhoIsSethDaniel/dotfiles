local i = require 'nvim-lsp-installer'
i.setup {
  ensure_installed = { 'bashls', 'sumneko_lua', 'perlnavigator', 'vimls', 'gopls@v0.8.3' },
  automatic_installation = true,
}

-- local disabled = {}
local disabled = { 'perlnavigator' }

local function setup_servers()
  local servers = i.get_installed_servers()

  for _, server in pairs(servers) do
    if not vim.tbl_contains(disabled, server.name) and not require('goldsmith').needed(server.name) then
      local config = require('lsp').get_config(server.name)
      require('lspconfig')[server.name].setup(config)
    end
  end
  require('lspconfig').perlpls.setup(require('lsp').get_config 'perlpls')
end

setup_servers()

-- require'vim.lsp.log'.set_level(vim.log.levels.TRACE)
require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
-- require('vim.lsp.log').set_level(vim.log.levels.INFO)
require('vim.lsp.log').set_format_func(vim.inspect)
