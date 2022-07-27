local M = {}

local function on_attach(client, bufnr)
  local function dump_caps()
    print(client.name .. ':')
    print(vim.inspect(client.server_capabilities))
  end

  -- dump_caps()

  local ft = vim.opt.filetype:get()
  if ft == 'go' or ft == 'gomod' then
    return
  end

  local map = vim.api.nvim_buf_set_keymap

  -- mappings
  local opts = { noremap = true, silent = true }

  map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map(bufnr, 'n', '<leader>cf', "<cmd>lua require'lsp-format'.format()<CR>", opts)

  map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  map(bufnr, 'n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map(bufnr, 'n', '<leader>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

function M.get_config(server)
  local ok, config = pcall(require, string.format('lsp.%s', server))
  if not ok then
    vim.api.nvim_err_writeln('failed to load server: ' .. server)
    config = {}
  end
  local cap = vim.lsp.protocol.make_client_capabilities()
  cap = require('cmp_nvim_lsp').update_capabilities(cap)
  config['capabilities'] = cap
  config['on_attach'] = function(client, bufnr)
    if server ~= 'gopls' then
      require('lsp-format').on_attach(client)
      on_attach(client, bufnr)
    end
  end
  return config
end

local function setup()
  -- require'vim.lsp.log'.set_level(vim.log.levels.TRACE)
  require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  -- require('vim.lsp.log').set_level(vim.log.levels.INFO)
  require('vim.lsp.log').set_format_func(vim.inspect)

  require('mason').setup {
    log_level = vim.log.levels.DEBUG,
  }

  local mlsp = require 'mason-lspconfig'

  local disabled = {}
  -- local disabled = { 'perlnavigator' }

  local has_goldsmith, g = pcall(require, 'goldsmith')
  local function goldsmith_managed(server)
    if has_goldsmith then
      return g.needed(server)
    else
      return false
    end
  end

  mlsp.setup {}
  mlsp.setup_handlers {
    function(server)
      if not vim.tbl_contains(disabled, server) and not goldsmith_managed(server) then
        require('lspconfig')[server].setup(M.get_config(server))
      end
    end,
  }
  -- require('lspconfig').perlpls.setup(M.get_config 'perlpls')

  require('mason-tool-installer').setup {
    ensure_installed = {
      'bash-language-server',
      'codespell',
      'editorconfig-checker',
      'gofumpt',
      'golangci-lint',
      'golines',
      'gomodifytags',
      'gopls',
      'gotests',
      'impl',
      'json-to-struct',
      'luacheck',
      'lua-language-server',
      'markdownlint',
      'perlnavigator',
      'prettier',
      'revive',
      'selene',
      'shellcheck',
      'shellharden',
      'shfmt',
      'staticcheck',
      'stylua',
      'vim-language-server',
      'vint',
    },
    auto_update = true,
    -- run_on_start = false,
  }

  vim.diagnostic.config { severity_sort = true }

  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

setup()

return M
