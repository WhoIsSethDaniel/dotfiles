local ok, neotest = pcall(require, 'neotest')
if ok then
  local function cmd(name, f, opts)
    vim.api.nvim_buf_create_user_command(0, name, f, opts or {})
  end
  local function key(mode, lhs, f, opts)
    vim.keymap.set(mode, lhs, f, vim.tbl_extend('keep', { buffer = 0 }, opts or {}))
  end
  local run = function(opts)
    return function()
      neotest.run.run(opts)
    end
  end
  local bufname = function(flags)
    return vim.fn.fnameescape(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), flags))
  end

  -- TODO: look for ways to complete test names
  cmd('GoTestNearest', run())
  cmd('GoTestRun', run(bufname ':p'))
  cmd('GoTestPkg', run(bufname ':p:h'))
  cmd('GoTestSuite', run(vim.fn.getcwd()))
  cmd('GoTestClear', function()
    neotest.output_panel.clear()
  end)

  key('n', '<leader>tp', function()
    neotest.output_panel.toggle()
  end)
  key('n', '<leader>ts', function()
    neotest.summary.toggle()
  end)
end

vim.filetype.add {
  extension = {
    gohtml = 'gotmpl',
    gotoml = 'gotmpl',
  },
}
