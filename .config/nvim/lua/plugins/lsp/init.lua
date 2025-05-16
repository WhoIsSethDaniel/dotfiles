--# selene: allow(mixed_table)
---@diagnostic disable:need-check-nil
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local has_lspconfig, _ = pcall(require, 'lspconfig')
if not has_lspconfig then
  return {
    setup = function()
      vim.api.nvim_echo(
        { { 'nvim-lspconfig is not installed; no default configuration for LSP' } },
        false,
        { err = true }
      )
    end,
  }
end

local M = {}

local disabled_lsp_servers = { 'templ' }
local no_inlay_hints = {}
local no_semantic_tokens = { 'gopls', 'lua_ls' }
local watch_files = {}
local manual_config_lsp = {}

local if_has_do = function(module, f)
  local ok, m = pcall(require, module)
  if ok then
    f(m)
  end
end

vim.api.nvim_create_autocmd({ 'LspDetach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    notify(client.name .. ' (unattached)')
  end,
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local bufnr = args.buf
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    notify(client.name .. ' (attached)')

    -- prefix diagnostics with the name of the client
    local ns = vim.lsp.diagnostic.get_namespace(client_id)
    vim.diagnostic.config({
      virtual_lines = {
        format = function(d)
          return string.format('%s: %s', client.name, d.message)
        end,
      },
    }, ns)

    if client.server_capabilities.documentSymbolProvider then
      if_has_do('nvim-navic', function(m)
        m.attach(client, bufnr)
      end)
    end

    -- turn on inlay hints
    if client.server_capabilities.inlayHintProvider and not vim.tbl_contains(no_inlay_hints, client.name) then
      vim.lsp.inlay_hint.enable(true)
    end

    -- turn off semantic token support
    if client.server_capabilities.semanticTokensProvider and vim.tbl_contains(no_semantic_tokens, client.name) then
      client.server_capabilities.semanticTokensProvider = nil
    end

    -- https://www.reddit.com/r/neovim/comments/1b4bk5h/psa_new_fswatch_watchfunc_backend_available_on/
    -- turn on automatic file watching
    if
      client.capabilities.workspace.didChangeWatchedFiles
      and client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration == false
      and vim.tbl_contains(watch_files, client.name)
    then
      client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
    end

    -- change priority of semantic tokens to be less than treesitter; see :h vim.highlight.priorities
    -- vim.highlight.priorities.semantic_tokens = 95

    -- selene: allow(unused_variable)
    ---@diagnostic disable-next-line:unused-local,unused-function
    local function dump_caps()
      -- print(vim.inspect(client.capabilities.workspace))
      -- print(vim.inspect(client.server_capabilities))
    end
    -- dump_caps()

    -- mappings
    local has_tele, _ = pcall(require, 'telescope')
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    if has_tele then
      map('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
      map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, opts)
      -- override default grr/gri (which only exists >= 0.11) and use telescope instead
      map('n', 'grr', require('telescope.builtin').lsp_references, opts)
      map('n', 'gri', require('telescope.builtin').lsp_implementations, opts)
    else
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    end
    if vim.fn.has 'nvim-0.11.0' == 0 then
      -- each of these is set by default in 0.11.0; see :h grn
      map('n', 'grn', vim.lsp.buf.rename, opts)
      map('n', 'gra', vim.lsp.buf.code_action, opts)
      -- map('n', 'grr', vim.lsp.buf.references, opts)
      map('n', '<C-S>', vim.lsp.buf.signature_help, opts)
    end
    if_has_do('conform', function(_)
      map('n', '<leader>cf', require('conform').format, opts)
    end)
  end,
})

function M.setup()
  -- require('vim.lsp.log').set_level(vim.log.levels.TRACE)
  -- require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  require('vim.lsp.log').set_level(vim.log.levels.INFO)
  -- require('vim.lsp.log').set_level(vim.log.levels.WARN)
  require('vim.lsp.log').set_format_func(vim.inspect)

  -- global diagnostic options
  vim.diagnostic.config {
    severity_sort = true,
    update_in_insert = false,
    signs = function()
      local icons = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
      return {
        text = {
          [vim.diagnostic.severity.ERROR] = icons['Error'],
          [vim.diagnostic.severity.WARN] = icons['Warn'],
          [vim.diagnostic.severity.HINT] = icons['Hint'],
          [vim.diagnostic.severity.INFO] = icons['Info'],
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
          [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      }
    end,
  }

  for _, server in ipairs(manual_config_lsp) do
    vim.lsp.enable(server)
    notify(server .. ' (manual)')
  end

  if_has_do('mason', function(mason)
    mason.setup {
      -- log_level = vim.log.levels.DEBUG,
      log_level = vim.log.levels.INFO,
      -- log_level = vim.log.levels.WARN,
      registries = {
        'github:mason-org/mason-registry',
        -- 'file:/home/seth/src/mason-registry',
      },
    }
    if_has_do('mason-lspconfig', function(m)
      for _, server in ipairs(m.get_installed_servers()) do
        if not vim.tbl_contains(disabled_lsp_servers, server) then
          notify(server .. ' (mason)')
        end
      end
      m.setup {
        automatic_enable = {
          exclude = disabled_lsp_servers,
        },
      }
    end)

    if_has_do('mason-tool-installer', function(m)
      m.setup {
        ensure_installed = {
          'bash-language-server',
          'dprint',
          'editorconfig-checker',
          'eugene',
          'golangci-lint',
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
          'pint',
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
        start_delay = 0,
      }
    end)
  end)
end

return M
