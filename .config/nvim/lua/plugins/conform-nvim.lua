-- return {
--   filetype = {
--     go = {
--       function()
--         local c = ft.go.golines()
--         c.args = { '--max-len=120' }
--         return c
--       end,
--     },
--     sh = {
--       function()
--         return {
--           exe = 'shellharden',
--           stdin = true,
--           args = { '--transform', "''" },
--         }
--       end,
--     },
--   },
-- }

-- local function prettier()
--   local f = fdef.prettier()
--   local m = string.match(futil.get_current_buffer_file_path(), '^(.*/work)')
--   if m then
--     table.insert(f.args, 1, string.format('%s/mm_website/.prettierrc.non-js.cjs', m))
--     table.insert(f.args, 1, '--config')
--     f.cwd = string.format('%s/mm_website', m)
--     return f
--   end
--   return f
-- end

-- local prettier = require 'conform.formatters.prettier'
-- local args = prettier.args
-- prettier.args = function()
--   local args = args
--   -- local m = string.match(vim.api.nvim_get_current_buf(), '^(.*/work)')
--   -- if m then
--   --   table.insert(args, 1, string.format('%s/mm_website/.prettierrc.non-js.cjs', m))
--   --   table.insert(args, 1, '--config')
--   --   f.cwd = string.format('%s/mm_website', m)
--   --   return f
--   -- end
--   print(vim.inspect(args))
--   return args
-- end

local shfmt = require 'conform.formatters.shfmt'
shfmt.args = function()
  return { '-i=4', '-ci', '-s', '-bn' }
end

local my_prettier = require 'conform.formatters.prettier'
require('conform').setup {
  formatters = {
    doit = function()
      print(vim.inspect(my_prettier))
      local p = vim.tbl_deep_extend('keep', {}, my_prettier)
      local b = vim.api.nvim_get_current_buf()
      local m = string.match(vim.api.nvim_buf_get_name(b), '^(.*/work)')
      if m then
        table.insert(p.args, 1, string.format('%s/mm_website/.prettierrc.non-js.cjs', m))
        table.insert(p.args, 1, '--config')
        p.cwd = function()
          return string.format('%s/mm_website', m)
        end
      end
      return p
    end,
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    -- go = { "golines"},
    gohtml = { 'prettier' },
    gohtmltmpl = { 'prettier' },
    json = { 'doit' },
    markdown = { 'prettier' },
    yaml = { 'prettier' },
    sh = {
      'shfmt',
      -- 'shellharden',
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  log_level = vim.log.levels.TRACE,
}
