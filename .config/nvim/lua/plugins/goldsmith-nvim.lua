local lsp = require 'lsp'

require('goldsmith').config {
  system = {
    debug = true,
    -- debug = false,
  },
  -- inlay_hints = {
  --   enabled = true,
  --   show_parameter_hints = true,
  --   show_variable_name = true,
  --   parameter_hints_prefix = '<< ',
  --   other_hints_prefix = '>> ',
  --   only_current_line = false,
  -- },
  mappings = {
    format = { '<leader>cf' },
    ['toggle-debug-console'] = { '<leader>gd' },
    ['test-last'] = { '<leader>tl' },
    ['test-a-nearest'] = { '<leader>tn' },
    ['test-suite'] = { '<leader>ts' },
    ['test-pkg'] = { '<leader>tp' },
    ['test-b-nearest'] = { '<leader>bn' },
    ['test-b-suite'] = { '<leader>bs' },
    ['test-b-pkg'] = { '<leader>bp' },
    ['alt-file'] = { '<leader>a' },
    ['run'] = { '<leader>gr' },
    ['build'] = { '<leader>gb' },
    ['super-close-any'] = { '<leader>cw' },
    ['contextual-help'] = { '<leader>h' },
  },
  testing = {
    window = {
      focus = false,
      pos = 'bottom',
    },
  },
  goinstall = {
    window = {
      focus = false,
    },
  },
  goget = {
    window = {
      focus = false,
    },
  },
  window = {
    width = 100,
  },
  gopls = {
    config = function()
      return lsp.get_config 'gopls'
    end,
  },
  format = {
    max_line_length = 100,
    comments = { enabled = true },
  },
  null = {
    enabled = true,
    staticcheck = false,
    gofmt = false,
    gofumpt = false,
    golines = true,
    ['golangci-lint'] = true,
    revive = false,
    run_setup = false,
    -- config = function()
    --   return lsp.get_config 'null-ls'
    -- end,
  },
  highlight = {
    current_symbol = false,
  },
}
