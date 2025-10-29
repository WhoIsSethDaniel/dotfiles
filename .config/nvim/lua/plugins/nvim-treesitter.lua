--  https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--  https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
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
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'perl', 'go', 'markdown' },
    callback = function()
      vim.treesitter.start()
    end,
  })
  require('nvim-treesitter').install(auto_install)
  -- for now: everything
  vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  vim.keymap.set({ 'x', 'o' }, 'af', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'x', 'o' }, 'if', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
  end)
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
