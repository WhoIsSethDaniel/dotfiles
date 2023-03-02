vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--color=never', '--files', '--hidden', '-g', '!.git' },
    hidden = true,
    search_dirs = { '~' },
  }
end, {})

vim.keymap.set('n', '<leader>fc', function()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--color=never', '--files', '--hidden', '-g', '!.git' },
    hidden = true,
  }
end, {})

vim.keymap.set('n', '<leader>gg', function()
  require('telescope.builtin').live_grep()
end, {})

vim.keymap.set('n', '<leader>go', function()
  require('telescope.builtin').live_grep { grep_open_files = true }
end, {})

vim.keymap.set('n', '<leader>fb', function()
  require('telescope.builtin').buffers { ignore_current_buffer = true }
end, {})

vim.keymap.set('n', '<leader>fm', function()
  require('telescope.builtin').oldfiles()
end, {})

vim.keymap.set('n', '<leader>gb', function()
  require('telescope.builtin').git_branches { show_remote_tracking_branches = true }
end, {})

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    layout_config = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
      prompt_position = 'bottom',
      width = 0.75,
      preview_cutoff = 120,
    },
    -- results_height = 1,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
        n = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
  extensions = {
    fzy_native = { override_generic_sorter = true, override_file_sorter = true },
    live_grep_args = {},
  },
}

local ok, _ = pcall(require, 'goldsmith')
if ok then
  require('telescope').load_extension 'goldsmith'
end
local ok, _ = pcall(require, 'reposession')
if ok then
  require('telescope').load_extension 'reposession'
end
local ok, _ = pcall(require, 'possession')
if ok then
  require('telescope').load_extension 'possession'
end
require('telescope').load_extension 'fzy_native'
require('telescope').load_extension 'live_grep_args'
