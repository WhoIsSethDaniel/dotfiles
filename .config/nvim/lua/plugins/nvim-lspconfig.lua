local i = require 'nvim-lsp-installer'

local function setup_servers()
  local servers = i.get_installed_servers()

  for _, server in pairs(servers) do
    if not require('goldsmith').needed(server.name) then
      local config = require('lsp').get_config(server.name)
      server:setup(config)
    end
  end
  -- require('lspconfig').perlpls.setup(require('lsp').get_config 'perlpls')

  -- Check if the config is already defined (useful when reloading this file)
  local configs = require 'lspconfig.configs'
  configs['perlnavigator'] = {
    default_config = {
      cmd = { 'node', '/home/seth/src/PerlNavigator/server/out/server.js', '--stdio' },
      root_dir = function(fname)
        return require('lspconfig').util.find_git_ancestor(fname)
      end,
      filetypes = { 'perl' },
      settings = {},
    },
  }
  require('lspconfig').perlnavigator.setup {}
end

setup_servers()

-- require'vim.lsp.log'.set_level(vim.log.levels.TRACE)
require'vim.lsp.log'.set_level(vim.log.levels.DEBUG)
-- require('vim.lsp.log').set_level(vim.log.levels.INFO)
require('vim.lsp.log').set_format_func(vim.inspect)
