-- https://github.com/stevearc/oil.nvim
local oil = require 'oil'
oil.setup {
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  default_file_explorer = true,
  columns = {
    'icon',
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'nvic',
  },
  -- Skip the confirmation popup for simple operations
  skip_confirm_for_simple_edits = true,
  watch_for_changes = true,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['g.'] = 'actions.toggle_hidden',
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, '.')
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return vim.startswith(name, '..')
    end,
    -- Sort file names in a more intuitive order for humans. Is less performant,
    -- so you may want to set to false if you work with large directories.
    natural_order = true,
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = 'rounded',
    win_options = {
      winblend = 10,
    },
  },
}
vim.keymap.set('n', '-', oil.open, { desc = 'Open parent directory' })
vim.keymap.set('n', '_', function()
  oil.open(vim.fn.getcwd())
end, { desc = 'Open project root directory' })

-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = { 'oil://*' },
--   callback = function()
--     local dir = oil.get_current_dir()
--     if vim.fn.isdirectory(dir) ~= 0 then
--       vim.cmd.lcd { dir }
--     end
--   end,
-- })
