-- https://github.com/folke/snacks.nvim
-- https://github.com/2KAbhishek/seeker.nvim

-- consider 'smart' snacks picker instead of seeker
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#smart
local seeker = require 'seeker'
seeker.setup {
  picker_provider = 'snacks',
}

local snacks = require 'snacks'
snacks.setup {
  bigfile = { enabled = true },
  input = { enabled = true },
  picker = {
    ui_select = true,
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
    layout = {
      preset = 'telescope',
    },
  },
}

local seek = function(mode, opts)
  seeker.seek {
    mode = mode,
    picker_opts = opts,
  }
end

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#keymaps
vim.keymap.set('n', '<leader>kk', function()
  snacks.picker.keymaps {
    plugins = true,
  }
end, {
  desc = 'Show keymaps.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#buffers
vim.keymap.set('n', '<leader>fb', function()
  snacks.picker.buffers {
    current = false,
    win = {
      input = {
        keys = {
          ['<c-d>'] = { 'bufdelete', mode = { 'n', 'i' } },
        },
      },
    },
  }
end, {
  desc = 'Select from the list of buffers.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep_buffers
vim.keymap.set('n', '<leader>go', function()
  snacks.picker.grep_buffers()
end, {
  desc = 'Grep files from the list of buffers.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_branches
local git_branches_all = false
vim.keymap.set('n', '<leader>gb', function()
  snacks.picker.git_branches {
    all = git_branches_all,
    actions = {
      toggle_git_branches_all = function(picker, _)
        git_branches_all = not git_branches_all
        picker.opts.all = git_branches_all
        picker:refresh()
      end,
    },
    win = {
      input = {
        keys = {
          ['<c-a>'] = { 'git_branch_add', mode = { 'n', 'i' } },
          ['<c-d>'] = { 'git_branch_del', mode = { 'n', 'i' } },
          ['<c-t>'] = { 'toggle_git_branches_all', mode = { 'n', 'i' } },
        },
      },
    },
  }
end, {
  desc = 'Select Git branches.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
vim.keymap.set('n', '<leader>ec', function()
  local cfg = '~/.config/nvim'
  seek('files', {
    hidden = true,
    dirs = { cfg },
  })
end, {
  desc = 'Find neovim configuration files.',
})

vim.keymap.set('n', '<leader>ff', function()
  seek('files', {
    hidden = true,
    dirs = { '~' },
  })
end, {
  desc = 'Find files within the home directory.',
})

vim.keymap.set('n', '<leader>fc', function()
  seek('files', {
    hidden = true,
  })
end, {
  desc = 'Find files within the current directory.',
})

-- use the directory of the current buffer
vim.keymap.set('n', '<leader>fd', function()
  local dirs = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  seek('files', {
    hidden = true,
    dirs = { vim.fs.dirname(vim.api.nvim_buf_get_name(0)) },
  })
end, {
  desc = 'Find files within the directory of the current buffer.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep
-- use the directory of the current buffer
vim.keymap.set('n', '<leader>gd', function()
  seek('grep', {
    dirs = { vim.fs.dirname(vim.api.nvim_buf_get_name(0)) },
  })
end, {
  desc = 'Grep all files within the directory of the current buffer.',
})

vim.keymap.set('n', '<leader>gg', function()
  seek 'grep'
end, {
  desc = 'Grep all files within the current directory.',
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#projects
vim.keymap.set('n', '<leader>pp', function()
  snacks.picker.projects {
    dev = {
      vim.env.HOME .. '/.local/share/nvim/site/pack/core/opt',
      vim.env.HOME .. '/src',
    },
    confirm = function(picker, select)
      picker:close()
      vim.fn.chdir(select.text)
      snacks.picker.files()
    end,
  }
end, {
  desc = 'Select the project to work on.',
})
