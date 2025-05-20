-- https://github.com/echasnovski/mini.ai
local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup {
  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {
    F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
  },
}
