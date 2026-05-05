-- https://github.com/folke/snacks.nvim
-- https://github.com/2KAbhishek/seeker.nvim

local seeker = require 'seeker'
seeker.setup {
  picker_provider = 'snacks',
}

local snacks = require 'snacks'
snacks.setup {
  bigfile = { enabled = true },
  input = { enabled = true },
}

local seek = function(mode, opts)
  seeker.seek {
    mode = mode,
    picker_opts = opts,
  }
end

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#buffers
vim.keymap.set('n', '<leader>fb', function()
  snacks.picker.buffers { current = false }
end, {})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep_buffers
vim.keymap.set('n', '<leader>go', function()
  snacks.picker.grep_buffers()
end, {})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_branches
vim.keymap.set('n', '<leader>gb', function()
  snacks.picker.git_branches()
end, {})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
vim.keymap.set('n', '<leader>ec', function()
  local cfg = '~/.config/nvim'
  local entries = {}
  for name, _ in vim.fs.dir(cfg) do
    if name ~= 'pack' then
      table.insert(entries, vim.fs.joinpath(cfg, name))
    end
  end

  seek('files', {
    hidden = true,
    dirs = entries,
  })
end, {})

vim.keymap.set('n', '<leader>ff', function()
  seek('files', {
    hidden = true,
    dirs = { '~' },
  })
end, {})

vim.keymap.set('n', '<leader>fc', function()
  seek('files', {
    hidden = true,
  })
end, {})

-- use the directory of the current buffer
vim.keymap.set('n', '<leader>fd', function()
  local dirs = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  seek('files', {
    hidden = true,
    dirs = { dirs },
  })
end, {})

-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep
-- use the directory of the current buffer
vim.keymap.set('n', '<leader>gd', function()
  seek('grep', {
    dirs = { vim.fs.dirname(vim.api.nvim_buf_get_name(0)) },
  })
end, {})

vim.keymap.set('n', '<leader>gg', function()
  seek 'grep'
end, {})
