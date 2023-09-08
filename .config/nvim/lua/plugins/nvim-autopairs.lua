-- https://github.com/windwp/nvim-autopairs
local pairs = require 'nvim-autopairs'
pairs.setup {
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  disable_in_macro = false,
  disable_in_visualblock = false,
  disable_in_replace_mode = true,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  enable_moveright = true,
  enable_afterquote = true,
  enable_check_bracket_line = true,
  enable_bracket_in_quote = true,
  enable_abbr = false,
  break_undo = true,
  check_ts = true,
  map_cr = true,
  map_bs = true,
  map_c_h = false,
  map_c_w = false,
  -- only if check_ts is true
  ts_config = {
    lua = { 'string', 'source' },
  },
  fast_wrap = {},
  -- fast_wrap = {
  --   map = '<M-e>',
  --   chars = { '{', '[', '(', '"', "'" },
  --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
  --   offset = 0, -- Offset from pattern match
  --   end_key = '$',
  --   keys = 'qwertyuiopzxcvbnmasdfghjkl',
  --   check_comma = true,
  --   highlight = 'Search',
  --   highlight_grey = 'Comment',
  -- },
}

-- cmp -- not certain what this is doing
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})

-- info on endwise: https://github.com/windwp/nvim-autopairs/wiki/Endwise
-- perhaps also see https://github.com/RRethy/nvim-treesitter-endwise
pairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
