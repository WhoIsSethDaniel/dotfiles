require('mason').setup {
  log_level = vim.log.levels.DEBUG,
}
local m = require 'mason-lspconfig'

m.setup {
  -- ensure_installed = { 'bashls', 'sumneko_lua', 'perlnavigator', 'vimls', 'gopls' },
  automatic_installation = false,
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'bash-language-server',
    'editorconfig-checker',
    'gofumpt',
    'golangci-lint',
    'golines',
    'gomodifytags',
    'gopls',
    'gotests',
    'impl',
    'json-to-struct',
    'lua-language-server',
    'luacheck',
    'misspell',
    'perlnavigator',
    'prettier',
    'revive',
    'shellcheck',
    'shfmt',
    'staticcheck',
    'stylua',
    'vim-language-server',
    'vint',
  },
  auto_update = true,
}

local disabled = {}
-- local disabled = { 'perlnavigator' }

m.setup_handlers {
  function(server)
    if not vim.tbl_contains(disabled, server) and not require('goldsmith').needed(server) then
      local config = require('lsp').get_config(server)
      require('lspconfig')[server].setup(config)
    end
  end,
}

-- require('lspconfig').perlpls.setup(require('lsp').get_config 'perlpls')

-- require'vim.lsp.log'.set_level(vim.log.levels.TRACE)
require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
-- require('vim.lsp.log').set_level(vim.log.levels.INFO)
require('vim.lsp.log').set_format_func(vim.inspect)
