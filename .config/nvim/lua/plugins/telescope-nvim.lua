vim.api.nvim_set_keymap(
  'n',
  '<leader>ff',
  '<cmd>lua require(\'telescope.builtin\').find_files({ hidden = true, search_dirs = { "~" } })<cr>',
  { noremap = true }
)
vim.api.nvim_set_keymap('n', '<leader>fc', "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>fb',
  "<cmd>lua require('telescope.builtin').buffers({ ignore_current_buffer = true })<cr>",
  { noremap = true }
)
vim.api.nvim_set_keymap('n', '<leader>fm', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", { noremap = true })

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
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = {},
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
  },
}

require('telescope').load_extension 'fzy_native'
require('telescope').load_extension 'goldsmith'
