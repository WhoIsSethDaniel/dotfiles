-- https://github.com/mhartington/formatter.nvim
local util = require 'formatter.util'
local fdef = require 'formatter.defaults'
local ft = require 'formatter.filetypes'

vim.api.nvim_create_augroup('Formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Formatter',
  pattern = { '*' },
  command = 'FormatWrite',
})

local function prettier()
  local f = fdef.prettier()
  local m = string.match(util.get_current_buffer_file_path(), '^(.*/work)')
  if m then
    table.insert(f.args, 1, string.format('%s/mm_website/.prettierrc.non-js.cjs', m))
    table.insert(f.args, 1, '--config')
    return f
  end
  return f
end

return {
  logging = true,
  log_level = vim.log.levels.ERROR,
  filetype = {
    go = {
      function()
        local c = ft.go.golines()
        c.args = { '--max-len=120' }
        return c
      end,
    },
    gohtml = {
      prettier,
    },
    gohtmltmpl = {
      prettier,
    },
    json = {
      prettier,
    },
    markdown = {
      prettier,
    },
    lua = {
      ft.lua.stylua,
    },
    sh = {
      function()
        local c = ft.sh.shfmt()
        c.args = { '-i=4', '-ci', '-s', '-bn' }
        return c
      end,
      function()
        return {
          exe = 'shellharden',
          stdin = true,
          args = { '--transform', "''" },
        }
      end,
    },
    yaml = {
      prettier,
    },
  },
}
