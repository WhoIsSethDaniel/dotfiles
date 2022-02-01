local lsp_status = require 'lsp-status'
lsp_status.config { current_function = false }
lsp_status.register_progress()

vim.diagnostic.config { severity_sort = true }

local M = {}

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- useful when debugging LSP
-- vim.lsp.set_log_level('TRACE')
-- require'vim.lsp.log'.set_format_func(vim.inspect)

local function on_attach(client, bufnr)
  -- typical value of client.resolved_capabilities for gopls ~0.7.0
  -- {
  --   call_hierarchy = true,
  --   code_action = {
  --     codeActionKinds = { "quickfix", "refactor.extract", "refactor.rewrite", "source.fixAll", "source.organizeImports" }
  --   },
  --   code_lens = true,
  --   code_lens_resolve = false,
  --   completion = true,
  --   declaration = false,
  --   document_formatting = true,
  --   document_highlight = true,
  --   document_range_formatting = false,
  --   document_symbol = true,
  --   execute_command = true,
  --   find_references = true,
  --   goto_definition = true,
  --   hover = true,
  --   implementation = true,
  --   rename = true,
  --   signature_help = true,
  --   signature_help_trigger_characters = { "(", "," },
  --   text_document_did_change = 2,
  --   text_document_open_close = true,
  --   text_document_save = {},
  --   text_document_save_include_text = false,
  --   text_document_will_save = false,
  --   text_document_will_save_wait_until = false,
  --   type_definition = true,
  --   workspace_folder_properties = {
  --     changeNotifications = "workspace/didChangeWorkspaceFolders",
  --     supported = true
  --   },
  --   workspace_symbol = true
  -- }

  local function dump_caps()
    print(client.name .. ':')
    print(vim.inspect(client.resolved_capabilities))
  end
  -- dump_caps()

  lsp_status.on_attach(client)
  local ft = vim.opt.filetype:get()
  if ft == 'go' or ft == 'gomod' then
    return
  end

  local map = vim.api.nvim_buf_set_keymap
  local function map_cond(cap, b, m, key, cmd, opts)
    if cap then
      map(b, m, key, cmd, opts)
    end
  end

  -- mappings
  local opts = { noremap = true, silent = true }
  local rc = client.resolved_capabilities

  map_cond(rc.declaration, bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map_cond(rc.goto_definition, bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map_cond(rc.hover, bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map_cond(rc.implementation, bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map_cond(rc.signature_help, bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map_cond(rc.type_definition, bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map_cond(rc.rename, bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map_cond(rc.find_references, bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map_cond(rc.code_action, bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map_cond(rc.document_formatting, bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting_seq_sync(nil,10000)<CR>', opts)
  map_cond(rc.document_range_formatting, bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting_seq_sync(nil,10000)<CR>', opts)

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
    config = {}
  end
  local cap = lsp_status.capabilities
  require('cmp_nvim_lsp').update_capabilities(cap)
  config['capabilities'] = cap
  config['on_attach'] = on_attach
  return config
end

return M
