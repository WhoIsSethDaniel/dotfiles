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

local disabled_lsp_servers = { 'templ' }
local no_inlay_hints = {}
local manual_config_lsp = {}

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
      vim.lsp.inlay_hint.enable(true)
    end

    local function dump_caps()
      print(client.name .. ':')
      print(vim.inspect(client.server_capabilities))
    end
    -- dump_caps()

    -- mappings
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
    map('n', 'gi', require('telescope.builtin').lsp_implementations, opts)
    map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, opts)
    map('n', 'gr', require('telescope.builtin').lsp_references, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    if_has_do('conform', function(_)
      map('n', '<leader>cf', require('conform').format, opts)
    end)
  end,
})

function M.get_config(server)
  local config = load_lsp_file(server)
  local cap = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp_nvim_lsp then
    cap = cmp_nvim_lsp.default_capabilities(cap)
    config = vim.tbl_deep_extend('force', { capabilities = cap }, config)
  end
  return config
end

function M.setup()
  -- require('vim.lsp.log').set_level(vim.log.levels.TRACE)
  -- require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  -- require('vim.lsp.log').set_level(vim.log.levels.INFO)
  require('vim.lsp.log').set_level(vim.log.levels.WARN)
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
    -- vim.api.nvim_set_keymap('n', '<leader>tv', '<Plug>(toggle-lsp-diag-vtext)', { silent = true })
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
      mlsp.setup {
        handlers = {
          function(server)
            if server == 'diagnosticls' then
              load_lsp_file 'diagnosticls'
            elseif not vim.tbl_contains(disabled_lsp_servers, server) then
              lspconf[server].setup(M.get_config(server))
              vim.schedule(function()
                print(server .. ' (mason)')
              end)
            end
          end,
        },
      }
    end)

    if_has_do('mason-tool-installer', function(m)
      m.setup {
        ensure_installed = {
          'bash-language-server',
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
          'markdownlint-cli2',
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
          'templ',
          'typos',
          'vim-language-server',
          'vint',
          'yamllint',
          'yq',
        },
        auto_update = true,
        -- run_on_start = false,
        start_delay = 1000,
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

  for _, server in ipairs(manual_config_lsp) do
    lspconf[server].setup(M.get_config(server))
    vim.schedule(function()
      print(server .. ' (manual)')
    end)
  end
end

return M
