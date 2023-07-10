-- https://github.com/mhartington/formatter.nvim
local util = require 'formatter.util'
local ft = require 'formatter.filetypes'

vim.api.nvim_create_augroup('Formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Formatter',
  pattern = { '*' },
  command = 'FormatWrite',
})

local function prettier()
  local d = require('formatter.defaults').prettier
  local m = string.match(util.get_current_buffer_file_path(), '^(.*/work)')
  if m then
    return vim.tbl_extend(
      'force',
      d(),
      { stdin = false, args = { '--config', string.format('%s/mm_website/.prettierrc.non-js.cjs', m) } }
    )
  else
    return d()
  end
end

-- TODO: prettier not yet working
return {
  logging = true,
  log_level = vim.log.levels.ERROR,
  filetype = {
    go = {
      ft.go.golines,
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
