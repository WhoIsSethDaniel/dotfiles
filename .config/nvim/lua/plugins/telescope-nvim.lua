-- https://github.com/nvim-telescope/telescope.nvim
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

vim.keymap.set('n', '<leader>pp', function()
  require('telescope').extensions.projects.projects {}
end, {})

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
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
        layout_strategy = 'vertical',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        path_display = { 'truncate' },
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
        -- fzy_native = { override_generic_sorter = true, override_file_sorter = true },
        -- live_grep_args = {},
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
    }

    local ok, _ = pcall(require, 'repossession')
    if ok then
      require('telescope').load_extension 'repossession'
    end
    local ok, _ = pcall(require, 'goofball')
    if ok then
      require('telescope').load_extension 'goofball'
    end
    local ok, _ = pcall(require, 'projects')
    if ok then
      require('telescope').load_extension 'projects'
    end
    -- require('telescope').load_extension 'fzy_native'
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'
  end,
})
