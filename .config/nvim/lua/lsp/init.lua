local has_goldsmith, g = pcall(require, 'goldsmith')
local has_lspsig, sig = pcall(require, 'lsp_signature')
local has_inlayhints, ih = pcall(require, 'lsp-inlayhints')

local M = {}

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if (not has_goldsmith and client.name == 'gopls') or client.name ~= 'gopls' then
      require('lsp-format').on_attach(client)
      if has_lspsig then
        sig.on_attach({}, bufnr)
      end
    end
    if has_inlayhints then
      ih.on_attach(client, bufnr, false)
    end
    if client.name ~= 'null-ls' and client.name ~= 'bashls' and client.name ~= 'perlnavigator' then
      require('nvim-navic').attach(client, bufnr)
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
    if has_inlayhints then
      map('n', '<leader>ih', function()
        ih.toggle()
      end, opts)
    end
  end,
})

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

local function setup()
  require('vim.lsp.log').set_level(vim.log.levels.TRACE)
  -- require('vim.lsp.log').set_level(vim.log.levels.DEBUG)
  -- require('vim.lsp.log').set_level(vim.log.levels.INFO)
  require('vim.lsp.log').set_format_func(vim.inspect)

  vim.diagnostic.config { severity_sort = true, update_in_insert = true }
  require('toggle_lsp_diagnostics').init(vim.diagnostic.config())
  vim.api.nvim_set_keymap('n', '<leader>td', '<Plug>(toggle-lsp-diag)', { silent = true })

  require('neodev').setup()

  require('mason').setup {
    -- log_level = vim.log.levels.DEBUG,
    log_level = vim.log.levels.INFO,
    registries = {
      'lua:mason-registry.index',
      'github:mason-org/mason-registry',
    },
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

  local has_null, null = pcall(require, 'null-ls')
  if has_null then
    null.setup(M.get_config 'null-ls')
  end

  local has_fmt, fmt = pcall(require, 'formatter')
  if has_fmt then
    fmt.setup(M.get_config 'formatter')
  end

  local has_lint, _ = pcall(require, 'lint')
  if has_lint then
    M.load_lsp_file 'lint'
  end

  require('mason-tool-installer').setup {
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

  if has_lspsig then
    sig.setup {
      bind = true,
      wrap = true,
      handler_opts = {
        border = 'rounded',
      },
    }
  end

  if has_inlayhints then
    ih.setup {
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
        only_current_line = false,
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
        -- highlight = 'Comment',
        highlight = 'LspInlayHint',
      },
      enabled_at_startup = true,
      debug_mode = false,
    }
  end

  require('lsp-format').setup {
    -- perl = { exclude = { 'perlnavigator' } },
  }

  require('nvim-navic').setup {
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

  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

setup()

return M
