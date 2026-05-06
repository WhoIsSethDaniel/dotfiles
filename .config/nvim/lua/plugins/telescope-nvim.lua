-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzy-native.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
-- https://github.com/natecraddock/telescope-zf-native.nvim
-- winborder w/ telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/3436

local telescope = require 'telescope'

local load = function(n)
  return pcall(telescope.load_extension, n)
end

telescope.setup {
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
    selection_caret = '󱞩 ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'vertical',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    -- path_display = {
    --   filename_first = {
    --     reverse_directories = true,
    --   },
    -- },
    winblend = 0,
    layout_config = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
      prompt_position = 'bottom',
      width = 0.90,
      -- preview_cutoff = 120,
    },
    -- results_height = 1,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = function(opts)
      return require('telescope.previewers').vim_buffer_cat.new(opts)
    end,
    grep_previewer = function(opts)
      return require('telescope.previewers').vim_buffer_vimgrep.new(opts)
    end,
    qflist_previewer = function(opts)
      return require('telescope.previewers').vim_buffer_qflist.new(opts)
    end,

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  pickers = {
    git_branches = {
      mappings = {
        i = {
          ['<cr>'] = require('telescope.actions').git_switch_branch,
        },
        n = {
          ['<cr>'] = require('telescope.actions').git_switch_branch,
        },
      },
    },
    find_files = {
      mappings = {
        i = {
          ['<c-k>'] = require('telescope.actions').cycle_history_prev,
          ['<c-j>'] = require('telescope.actions').cycle_history_next,
        },
      },
    },
    live_grep = {
      mappings = {
        i = {
          ['<c-k>'] = require('telescope.actions').cycle_history_prev,
          ['<c-j>'] = require('telescope.actions').cycle_history_next,
        },
      },
    },
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
          ['<c-k>'] = require('telescope.actions').cycle_history_prev,
          ['<c-j>'] = require('telescope.actions').cycle_history_next,
        },
        n = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
  extensions = {
    live_grep_args = {},
    fzy_native = { override_generic_sorter = true, override_file_sorter = true },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
    },
    ['zf-native'] = {
      -- options for sorting file-like items
      file = {
        -- override default telescope file sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- enable zf filename match priority
        match_filename = true,

        -- optional function to define a sort order when the query is empty
        initial_sort = nil,

        -- set to false to enable case sensitive matching
        smart_case = true,
      },

      -- options for sorting all other items
      generic = {
        -- override default telescope generic item sorter
        enable = true,

        -- highlight matching text in results
        highlight_results = true,

        -- disable zf filename match priority
        match_filename = false,

        -- optional function to define a sort order when the query is empty
        initial_sort = nil,

        -- set to false to enable case sensitive matching
        smart_case = true,
      },
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = false,
      -- Highlight group used for the path in the picker, default is "String"
      path_hl = 'String',
    },
  },
}

load 'goofball'
load 'repossession'
