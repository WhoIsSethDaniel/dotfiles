local has_lspconfig, lspconf = pcall(require, 'lspconfig')
if not has_lspconfig then
  return {
    get_config = function(server)
      vim.api.nvim_err_writeln(string.format('empty get_config request for %s', server))
      return {}
    end,
    setup = function()
      vim.api.nvim_err_writeln 'nvim-lspconfig is not installed; no configuration for LSP'
    end,
  }
end

local M = {}

local disabled_lsp_servers = {}
local no_inlay_hints = { 'lua_ls' }

local if_has_do = function(module, f)
  local ok, m = pcall(require, module)
  if ok then
    f(m)
  end
end

local load_lsp_file = function(f)
  local ok, config = pcall(require, string.format('plugins.lsp.%s', f))
  if not ok then
    vim.api.nvim_err_writeln('failed to load lsp config: ' .. f)
    config = {}
  end
  return config
end

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local bufnr = args.buf
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    if client.server_capabilities.documentSymbolProvider then
      if_has_do('nvim-navic', function(m)
        m.attach(client, bufnr)
      end)
    end
    if client.server_capabilities.inlayHintProvider and not vim.tbl_contains(no_inlay_hints, client.name) then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end

    local function dump_caps()
      print(client.name .. ':')
      print(vim.inspect(client.server_capabilities))
    end
    -- dump_caps()

    local map = vim.keymap.set

    -- mappings
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    if_has_do('conform', function(_)
      map('n', '<leader>cf', "<cmd>lua require'conform'.format()<CR>", opts)
    end)

    map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    map('n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map('n', '<leader>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  end,
})

function M.get_config(server)
  local config = load_lsp_file(server)
  local cap = vim.lsp.protocol.make_client_capabilities()
  cap = require('cmp_nvim_lsp').default_capabilities(cap)
  config = vim.tbl_deep_extend('force', { capabilities = cap }, config)
  return config
end

function M.setup()
  -- require('vim.lsp.log').set_level(vim.log.levels.TRACE)
  -- require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  require('vim.lsp.log').set_level(vim.log.levels.INFO)
  require('vim.lsp.log').set_format_func(vim.inspect)

  local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  vim.diagnostic.config { severity_sort = true, update_in_insert = true }
  if_has_do('toggle_lsp_diagnostics', function(m)
    m.init(vim.diagnostic.config())
    vim.api.nvim_set_keymap('n', '<leader>td', '<Plug>(toggle-lsp-diag)', { silent = true })
  end)

  if_has_do('mason', function(mason)
    mason.setup {
      -- log_level = vim.log.levels.DEBUG,
      log_level = vim.log.levels.INFO,
      registries = {
        'lua:mason-registry.index',
        'github:mason-org/mason-registry',
        -- 'file:/home/seth/src/mason-registry',
      },
    }

    if_has_do('mason-lspconfig', function(mlsp)
      mlsp.setup {}
      mlsp.setup_handlers {
        function(server)
          if server == 'diagnosticls' then
            load_lsp_file 'diagnosticls'
          elseif not vim.tbl_contains(disabled_lsp_servers, server) then
            lspconf[server].setup(M.get_config(server))
          end
        end,
      }
    end)

    if_has_do('mason-tool-installer', function(m)
      m.setup {
        ensure_installed = {
          'bash-language-server',
          'cbfmt',
          'dprint',
          'editorconfig-checker',
          'glow',
          'golangci-lint',
          'golines',
          'gomodifytags',
          'gopls',
          'gotests',
          'gotestsum',
          'impl',
          'json-to-struct',
          'lua-language-server',
          'markdownlint',
          'marksman',
          'perlnavigator',
          'prettier',
          'selene',
          'shellcheck',
          'shellharden',
          'shfmt',
          'sqlfluff',
          'staticcheck',
          'stylua',
          'typos',
          'vim-language-server',
          'vint',
          'yamllint',
          'yq',
        },
        auto_update = true,
        -- run_on_start = false,
        -- start_delay = 1000,
      }
    end)
  end)

  if_has_do('nvim-navic', function(m)
    m.setup {
      highlight = false,
      separator = ' > ',
      depth_limit = 0,
      depth_limit_indicator = '..',
    }
  end)
end

return M
