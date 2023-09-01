-- https://github.com/stevearc/conform.nvim
local c = require 'conform'

require('conform.formatters.shfmt').args = function()
  return { '-i=4', '-ci', '-s', '-bn' }
end

require('conform.formatters.golines').args = function()
  return { '--max-len=120' }
end

require('conform').formatters.prettier = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local m = string.match(bufname, '^(.*/work)')
  local default = require 'conform.formatters.prettier'
  if m then
    return vim.tbl_deep_extend('force', default, {
      args = { string.format('--config=%s/mm_website/.prettierrc.non-js.cjs', m), '--stdin-filepath', '$FILENAME' },
      cwd = function()
        return string.format('%s/mm_website', m)
      end,
    })
  end
end

c.setup {
  formatters_by_ft = {
    go = { 'golines' },
    gohtml = { 'prettier' },
    gohtmltmpl = { 'prettier' },
    json = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    -- perl = { 'perltidy', 'perlimports' },
    sh = {
      formatters = {
        'shfmt',
        'shellharden',
      },
      run_all_formatters = true,
    },
    yaml = { 'prettier' },
  },
  -- format_on_save = {
  --   timeout_ms = 15000,
  --   lsp_fallback = true,
  -- },
  log_level = vim.log.levels.TRACE,
}

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*',
  callback = function(args)
    local to = 500
    if vim.bo[args.buf].filetype == 'perl' then
      to = 15000
    end
    c.format { timeout_ms = to, lsp_fallback = true, bufnr = args.buf }
  end,
})
