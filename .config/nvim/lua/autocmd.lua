local terminal_open_setup = function()
  -- allow window movements
  vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { silent = true, noremap = true })
  vim.opt_local.signcolumn = 'no'
  -- vim.opt_local.number = false
  -- vim.opt_local.relativenumber = false
  -- vim.api.nvim_command 'startinsert'
end

-- create any missing intermediate directories for files that do not exist
local create_missing_dirs = function()
  local dir = vim.fn.expand '<afile>:h:p'
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
    vim.api.nvim_command('saveas! ' .. vim.fn.expand '<afile>')
  end
end

-- find all third-party plugins and rebuild the help tags
local rebuild_help = function()
  print 'rebuild all third-party plugin help tags'
  for _, rtdir in pairs(vim.opt.runtimepath:get()) do
    local docdir = vim.fn.glob(vim.fn.expand(vim.fn.fnameescape(rtdir .. '/doc')))
    local tagsfile = vim.fn.glob(docdir .. '/tags')
    if
      (#tagsfile > 0 and vim.fn.filewritable(tagsfile) == 1) or (#tagsfile == 0 and vim.fn.filewritable(docdir) == 2)
    then
      vim.api.nvim_command('helptags' .. docdir)
    end
  end
end

local autocmds = {
  doc_settings_and_win = {
    {
      FileType = {
        pattern = { 'help', 'man' },
        command = 'wincmd L',
      },
    },
    {
      FileType = {
        pattern = { 'lir', 'help', 'man' },
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.bufhidden = 'wipe'
        end,
      },
    },
  },
  highlight_yank = {
    {
      TextYankPost = {
        callback = function()
          vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500, on_visual = true }
        end,
      },
    },
  },
  terminal_settings = {
    {
      TermOpen = {
        callback = function()
          terminal_open_setup()
        end,
      },
    },
    {
      BufEnter = {
        pattern = { 'term://*' },
        command = 'startinsert',
      },
    },
  },
  create_missing_dirs = {
    {
      BufWritePre = {
        callback = function()
          create_missing_dirs()
        end,
      },
    },
  },
  vim_on_start = {
    {
      VimEnter = {
        callback = function()
          rebuild_help()
          vim.cmd [[ TSUpdate ]]
        end,
      },
    },
  },
  neovim_remote = {
    {
      FileType = {
        pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
        callback = function()
          vim.opt_local.bufhidden = 'wipe'
        end,
      },
    },
  },
}

-- setup all autocmds
do
  for group, grpdef in pairs(autocmds) do
    vim.api.nvim_create_augroup(group, { clear = true })
    for _, events in ipairs(grpdef) do
      -- this never has more than one event
      for event, eventdef in pairs(events) do
        vim.api.nvim_create_autocmd(event, eventdef)
      end
    end
  end
end
