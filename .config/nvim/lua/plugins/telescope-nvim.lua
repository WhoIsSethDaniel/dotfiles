-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzy-native.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
-- https://github.com/natecraddock/telescope-zf-native.nvim
-- winborder w/ telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/3436

local builtin = require 'telescope.builtin'
local telescope = require 'telescope'

local load = function(n)
  return pcall(telescope.load_extension, n)
end

vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files {
    find_command = { 'rg', '--color=never', '--files', '--hidden', '-g', '!.git' },
    hidden = true,
    search_dirs = { '~' },
  }
end, {})

vim.keymap.set('n', '<leader>ec', function()
  local cfg = '~/.config/nvim'
  local entries = {}
  for name, _ in vim.fs.dir(cfg) do
    if name ~= 'pack' then
      table.insert(entries, vim.fs.joinpath(cfg, name))
    end
  end

  builtin.find_files {
    find_command = { 'rg', '--color=never', '--files', '--hidden', '-g', '!.git' },
    hidden = true,
    search_dirs = entries,
  }
end, {})

vim.keymap.set('n', '<leader>fc', function()
  builtin.find_files {
    find_command = { 'rg', '--color=never', '--files', '--hidden', '-g', '!.git' },
    hidden = true,
  }
end, {})

vim.keymap.set('n', '<leader>gg', function()
  builtin.live_grep()
end, {})

vim.keymap.set('n', '<leader>go', function()
  builtin.live_grep { grep_open_files = true }
end, {})

vim.keymap.set('n', '<leader>fb', function()
  builtin.buffers { ignore_current_buffer = true }
end, {})

vim.keymap.set('n', '<leader>fm', function()
  builtin.oldfiles()
end, {})

vim.keymap.set('n', '<leader>gb', function()
  builtin.git_branches { show_remote_tracking_branches = true }
end, {})

local has_workspaces, _ = load 'workspaces'
vim.keymap.set('n', '<leader>pp', function()
  if has_workspaces then
    local ws = require 'workspaces'
    local plugindir = vim.fs.normalize '~/.config/nvim/pack/git-plugins/opt/'
    local entries = ws.get()
    local current = {}
    for _, entry in ipairs(entries) do
      if
        string.match(entry.path, string.gsub(plugindir, '-', '%%-')) == plugindir
        and vim.fn.isdirectory(entry.path) == 0
      then
        ws.remove(entry.name)
      else
        current[entry.path] = entry.path
      end
    end
    for name, _ in vim.fs.dir(plugindir) do
      local path = vim.fs.joinpath(plugindir, name) .. '/'
      if string.match(name, '^%.') == nil and current[path] == nil then
        ws.add(path)
      end
    end
    vim.cmd [[Telescope workspaces]]
  end
end, {})

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
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

    load 'fzf'
    load 'goofball'
    load 'ui-select'
    load 'repossession'
    load 'workspaces'
    load 'zf-native'
  end,
})
