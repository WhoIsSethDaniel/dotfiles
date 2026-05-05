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

-- local has_workspaces = require 'workspaces'
-- vim.keymap.set('n', '<leader>pp', function()
--   if has_workspaces then
--     local ws = require 'workspaces'
--     local plugindir = vim.fs.normalize '~/.local/share/nvim/site/pack/core/opt'
--     local entries = ws.get()
--     local current = {}
--     for _, entry in ipairs(entries) do
--       if
--         (
--           string.match(entry.path, string.gsub(plugindir, '-', '%%-')) == plugindir
--           and vim.fn.isdirectory(entry.path) == 0
--         ) or vim.fn.isdirectory(entry.path) == 0
--       then
--         ws.remove(entry.name)
--       else
--         current[entry.path] = entry.path
--       end
--     end
--     for name, _ in vim.fs.dir(plugindir) do
--       local path = vim.fs.joinpath(plugindir, name) .. '/'
--       if string.match(name, '^%.') == nil and current[path] == nil then
--         ws.add(path)
--       end
--     end
--     snacks.picker.projects {
--       ws.get(),
--       {
--         prompt = 'Select workspace:',
--       },
--       function(choice)
--         ws.open(choice)
--       end,
--     }
--     -- vim.cmd.Telescope { 'workspaces' }
--   end
-- end, {})
