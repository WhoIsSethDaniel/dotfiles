-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
local masterts, _ = pcall(require, 'nvim-treesitter.configs')
if not masterts then
  require('nvim-treesitter-textobjects').setup {
    move = {
      set_jumps = true,
    },
  }

  vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
    require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
    require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
    require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
    require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
  end)
end
