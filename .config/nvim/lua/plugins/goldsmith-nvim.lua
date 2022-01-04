local lsp = require 'lsp'

vim.cmd [[ cabbrev GoDocAll GoDoc -all ]]

require('goldsmith').config {
  system = {
    debug = true,
    -- debug = false,
  },
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
    max_line_length = 120,
    comments = { enabled = true },
  },
  null = {
    staticcheck = false,
    gofmt = false,
    gofumpt = false,
    golines = true,
    ['golangci-lint'] = { config_file = '.golangci.yml' },
    revive = { config_file = 'revive.toml' },
    config = function()
      return lsp.get_config 'null-ls'
    end,
  },
  highlight = {
    current_symbol = false,
  },
}