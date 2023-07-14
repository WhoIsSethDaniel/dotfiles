local has_goldsmith, g = pcall(require, 'goldsmith')

local M = {}

local if_has_then = function(module, f)
  local ok, m = pcall(require, module)
  if ok then
    f(m)
  end
end

function M.load_lsp_file(f)
  local ok, config = pcall(require, string.format('lsp.%s', f))
  if not ok then
    vim.api.nvim_err_writeln('failed to load lsp config: ' .. f)
    config = {}
  end
  return config
end

function M.get_config(server)
  local config = M.load_lsp_file(server)
  local cap = vim.lsp.protocol.make_client_capabilities()
  cap = require('cmp_nvim_lsp').default_capabilities(cap)
  config = vim.tbl_deep_extend('force', { capabilities = cap }, config)
  return config
end

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if (not has_goldsmith and client.name == 'gopls') or client.name ~= 'gopls' then
      if_has_then('lsp-format', function(m)
        m.on_attach(client)
      end)
      if_has_then('lsp_signature', function(m)
        m.on_attach({}, bufnr)
      end)
    end
    if client.name ~= 'null-ls' and client.name ~= 'bashls' and client.name ~= 'perlnavigator' then
      if_has_then('nvim-navic', function(m)
        m.attach(client, bufnr)
      end)
    end

    local function dump_caps()
      print(client.name .. ':')
      print(vim.inspect(client.server_capabilities))
    end

    -- dump_caps()

    if has_goldsmith and client.name == 'gopls' then
      return
    end

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

function M.setup()
  -- require('vim.lsp.log').set_level(vim.log.levels.TRACE)
  -- require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  require('vim.lsp.log').set_level(vim.log.levels.INFO)
  require('vim.lsp.log').set_format_func(vim.inspect)

  vim.diagnostic.config { severity_sort = true, update_in_insert = true }
  if_has_then('toggle_lsp_diagnostics', function(m)
    m.init(vim.diagnostic.config())
    vim.api.nvim_set_keymap('n', '<leader>td', '<Plug>(toggle-lsp-diag)', { silent = true })
  end)

  if_has_then('neodev', function(m)
    m.setup()
  end)

  if_has_then('mason', function(mason)
    mason.setup {
      -- log_level = vim.log.levels.DEBUG,
      log_level = vim.log.levels.INFO,
      registries = {
        'lua:mason-registry.index',
        'github:mason-org/mason-registry',
      },
    }

    if_has_then('lspconfig', function(lspconf)
      local disabled = {}

      local function goldsmith_managed(server)
        if has_goldsmith then
          return g.needed(server)
        else
          return false
        end
      end

      if_has_then('mason-lspconfig', function(mlsp)
        mlsp.setup {}
        mlsp.setup_handlers {
          function(server)
            if not vim.tbl_contains(disabled, server) and not goldsmith_managed(server) then
              lspconf[server].setup(M.get_config(server))
            end
          end,
        }
      end)
    end)

    if_has_then('null-ls', function(m)
      m.setup(M.get_config 'null-ls')
    end)

    if_has_then('formatter', function(m)
      m.setup(M.get_config 'formatter')
    end)

    if_has_then('lint', function()
      M.load_lsp_file 'lint'
    end)

    if_has_then('mason-tool-installer', function(m)
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

  if_has_then('lsp_signature', function(m)
    m.setup {
      bind = true,
      wrap = true,
      handler_opts = {
        border = 'rounded',
      },
    }
  end)

  if_has_then('lsp-format', function(m)
    m.setup {
      -- perl = { exclude = { 'perlnavigator' } },
    }
  end)

  if_has_then('nvim-navic', function(m)
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
