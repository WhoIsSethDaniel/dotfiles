--  https://github.com/nvim-treesitter/nvim-treesitter/tree/main
---@diagnostic disable-next-line:missing-fields

-- main branch treesitter
-- require('nvim-treesitter').install {
--   'comment',
--   'diff',
--   'luadoc',
--   'pod',
--   'regex',
--   'sql',
-- }

-- master branch treesitter
require('nvim-treesitter.configs').setup {
  auto_install = true,
  -- the comment parser is for comment *tags* such as TODO and FIXME;
  -- see https://github.com/stsewd/tree-sitter-comment
  ensure_installed = {
    'comment',
    'diff',
    'luadoc',
    'pod',
    'regex',
    'sql',
  },
  -- ignore_install = { 'cooklang' },
  autopairs = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
    enable_quotes = true,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']]'] = '@function.outer',
      },
      goto_next_end = {
        [']['] = '@function.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
      },
      goto_previous_end = {
        ['[]'] = '@function.outer',
      },
    },
  },
}
