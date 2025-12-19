--  https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--  https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
--  https://www.reddit.com/r/neovim/comments/1pndf9e/my_new_nvimtreesitter_configuration_for_the_main/
local masterts, _ = pcall(require, 'nvim-treesitter.configs')

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd.TSUpdate()
  end,
})

local auto_install = {
  'comment',
  'diff',
  'luadoc',
  'pod',
  'regex',
  'sql',
}

-- main branch treesitter
if not masterts then
  local ts = require 'nvim-treesitter'

  ts.install(auto_install)

  local ignore_filetypes = {
    'checkhealth',
    'lazy',
    'mason',
    'snacks_dashboard',
    'snacks_notif',
    'snacks_win',
  }

  -- Auto-install parsers and enable highlighting on FileType
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
    desc = 'Enable treesitter highlighting and indentation',
    callback = function(event)
      if vim.tbl_contains(ignore_filetypes, event.match) then
        return
      end

      local lang = vim.treesitter.language.get_lang(event.match) or event.match
      local buf = event.buf

      -- Start highlighting immediately (works if parser exists)
      pcall(vim.treesitter.start, buf, lang)

      -- Enable treesitter indentation
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- Install missing parsers (async, no-op if already installed)
      ts.install { lang }
    end,
  })
else
  -- master branch treesitter
  ---@diagnostic disable-next-line:missing-fields
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    -- the comment parser is for comment *tags* such as TODO and FIXME;
    -- see https://github.com/stsewd/tree-sitter-comment
    ensure_installed = auto_install,
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
end
