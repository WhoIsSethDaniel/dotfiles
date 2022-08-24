local has_goldsmith, g = pcall(require, 'goldsmith')

local M = {}

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if (not has_goldsmith and client.name == 'gopls') or client.name ~= 'gopls' then
      require('lsp-format').on_attach(client)
      -- require('lsp_signature').on_attach({}, bufnr)
    end
    require('lsp-inlayhints').on_attach(client, bufnr, false)

    local function dump_caps()
      print(client.name .. ':')
      print(vim.inspect(client.server_capabilities))
    end
    -- dump_caps()

    if client.name == 'gopls' then
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
  end,
})

function M.get_config(server)
  local ok, config = pcall(require, string.format('lsp.%s', server))
  if not ok then
    vim.api.nvim_err_writeln('failed to load server: ' .. server)
    config = {}
  end
  local cap = vim.lsp.protocol.make_client_capabilities()
  cap = require('cmp_nvim_lsp').update_capabilities(cap)
  config = vim.tbl_deep_extend('force', { capabilities = cap }, config)
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
      'cbfmt',
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
    start_delay = 5000,
  }

  require('lsp_signature').setup {
    bind = true,
    wrap = true,
    handler_opts = {
      border = 'rounded',
    },
  }

  require('lsp-inlayhints').setup {
    inlay_hints = {
      parameter_hints = {
        show = true,
        prefix = '<< ',
        separator = ', ',
        remove_colon_start = false,
        remove_colon_end = true,
      },
      type_hints = {
        -- type and other hints
        show = true,
        prefix = '',
        separator = ', ',
        remove_colon_start = false,
        remove_colon_end = false,
      },
      -- separator between types and parameter hints. Note that type hints are
      -- shown before parameter
      labels_separator = '  ',
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- highlight group
      highlight = 'Comment',
    },
    debug_mode = false,
  }

  require('lsp-format').setup {
    perl = { exclude = { 'perlnavigator' } },
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
