local M = {}

function M.terminal_open_setup()
  -- allow window movements
  vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { silent = true, noremap = true })
  vim.opt_local.signcolumn = 'no'
  -- vim.opt_local.number = false
  -- vim.opt_local.relativenumber = false
  -- vim.api.nvim_command 'startinsert'
end

-- create any missing intermediate directories for files that do not exist
function M.create_missing_dirs()
  local dir = vim.fn.expand '<afile>:h:p'
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
    vim.api.nvim_command('saveas! ' .. vim.fn.expand '<afile>')
  end
end

-- find all third-party plugins and rebuild the help tags
function M.rebuild_help()
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

return M
