local pairs = require('nvim-autopairs')
pairs.setup {
  map_bs = true,
  map_c_h = false,
  map_c_w = false,
  map_cr = true,
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  disable_in_macro = false,
  disable_in_visualblock = false,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  check_ts = false,
  enable_moveright = true,
  enable_afterquote = true,
  enable_check_bracket_line = true,
  -- only if check_ts is true
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
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

-- info on endwise: https://github.com/windwp/nvim-autopairs/wiki/Endwise
-- perhaps also see https://github.com/RRethy/nvim-treesitter-endwise
pairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
