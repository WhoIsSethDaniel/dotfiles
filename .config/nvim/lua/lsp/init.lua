local has_lspconfig, lspconf = pcall(require, 'lspconfig')
if not has_lspconfig then
  return {
    get_config = function()
      return {}
    end,
    setup = function()
      vim.api.nvim_err_writeln 'nvim-lspconfig is not installed; no configuration for LSP'
    end,
  }
end

local M = {}

local if_has_do = function(module, f)
  local ok, m = pcall(require, module)
  if ok then
    f(m)
  end
end

local load_lsp_file = function(f)
  local ok, config = pcall(require, string.format('lsp.%s', f))
  if not ok then
    vim.api.nvim_err_writeln('failed to load lsp config: ' .. f)
    config = {}
  end
  return config
end

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    local bufnr = args.buf
    if_has_do('lsp-format', function(m)
      m.on_attach(client)
    end)
    if_has_do('lsp_signature', function(m)
      m.on_attach({}, bufnr)
    end)
    if client.name ~= 'null-ls' and client.name ~= 'bashls' and client.name ~= 'perlnavigator' then
      if_has_do('nvim-navic', function(m)
        m.attach(client, bufnr)
      end)
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
    map('n', '<leader>cf', "<cmd>lua require'lsp-format'.format({})<CR>", opts)

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

  vim.diagnostic.config { severity_sort = true, update_in_insert = true }
  if_has_do('toggle_lsp_diagnostics', function(m)
    m.init(vim.diagnostic.config())
    vim.api.nvim_set_keymap('n', '<leader>td', '<Plug>(toggle-lsp-diag)', { silent = true })
  end)

  if_has_do('neodev', function(m)
    m.setup()
  end)

  if_has_do('mason', function(mason)
    mason.setup {
      -- log_level = vim.log.levels.DEBUG,
      log_level = vim.log.levels.INFO,
      registries = {
        'lua:mason-registry.index',
        'github:mason-org/mason-registry',
      },
    }

    local disabled = {}

    if_has_do('mason-lspconfig', function(mlsp)
      mlsp.setup {}
      mlsp.setup_handlers {
        function(server)
          if not vim.tbl_contains(disabled, server) then
            lspconf[server].setup(M.get_config(server))
          end
        end,
      }
    end)

    if_has_do('null-ls', function(m)
      m.setup(M.get_config 'null-ls')
    end)

    if_has_do('formatter', function(m)
      m.setup(M.get_config 'formatter')
    end)

    if_has_do('lint', function()
      load_lsp_file 'lint'
    end)

    if_has_do('mason-tool-installer', function(m)
      m.setup {
        ensure_installed = {
          'bash-language-server',
          'cbfmt',
          'codespell',
          'editorconfig-checker',
          'glow',
          'gofumpt',
          'golangci-lint',
          'golines',
          'gomodifytags',
          'gopls',
          'gospel',
          'gotests',
          'gotestsum',
          'impl',
          'json-to-struct',
          'lua-language-server',
          'markdownlint',
          'marksman',
          'perlnavigator',
          'prettier',
          'revive',
          'selene',
          'shellcheck',
          'shellharden',
          'shfmt',
          'sqlfluff',
          'staticcheck',
          'stylua',
          'vim-language-server',
          'vint',
          'yamlfmt',
          'yamllint',
        },
        auto_update = true,
        -- run_on_start = false,
        start_delay = 1000,
      }
    end)
  end)

  if_has_do('lsp_signature', function(m)
    m.setup {
      bind = true,
      wrap = true,
      handler_opts = {
        border = 'rounded',
      },
    }
  end)

  if_has_do('lsp-format', function(m)
    m.setup {
      -- perl = { exclude = { 'perlnavigator' } },
    }
  end)

  if_has_do('nvim-navic', function(m)
    m.setup {
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = '練',
        Interface = '練',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = '◩ ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = 'ﳠ ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
      highlight = false,
      separator = ' > ',
      depth_limit = 0,
      depth_limit_indicator = '..',
    }
  end)

  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

return M
