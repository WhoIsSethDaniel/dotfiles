-- https://github.com/mfussenegger/nvim-lint
local l = require 'lint'

local ag = vim.api.nvim_create_augroup('Linting', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost', 'VimEnter', 'BufEnter' }, {
  group = ag,
  pattern = { '*' },
  callback = function()
    l.try_lint()
  end,
})

local mdl = l.linters.markdownlint
mdl.args = {
  function()
    local conf = vim.fs.find('.markdownlint.jsonc', {
      upward = true,
      stop = vim.fs.dirname(vim.uv.os_homedir()),
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    })
    if #conf > 0 then
      return string.format('--config=%s', conf[1])
    end
  end,
}

local sel = l.linters.selene
sel.ignore_exitcode = false
table.insert(sel.args, 1, function()
  local conf = vim.fs.find('selene.toml', {
    upward = true,
    stop = vim.fs.dirname(vim.uv.os_homedir()),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })
  if #conf > 0 then
    return string.format('--config=%s', conf[1])
  end
end)

local sf = l.linters.sqlfluff
table.insert(sf.args, 2, '--dialect=postgres')

local yl = l.linters.yamllint
table.insert(yl.args, 1, function()
  local conf = vim.fs.find('.yamllintrc', {
    upward = true,
    stop = vim.fs.dirname(vim.uv.os_homedir()),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })
  if #conf > 0 then
    return string.format('--config-file=%s', conf[1])
  end
end)

-- l.linters.perlimports = function()
--   local filename = vim.api.nvim_buf_get_name(0)
--   return {
--     cmd = 'perlimports',
--     stdin = true,
--     args = { '--lint', '--json', '--read-stdin', '--filename', filename },
--     stream = 'stderr',
--     parser = function(output)
--       local result = vim.fn.split(output, '\n')
--       local diagnostics = {}
--       for _, message in ipairs(result) do
--         local decoded = vim.json.decode(message)
--         table.insert(diagnostics, {
--           lnum = decoded.location.start.line - 1,
--           col = decoded.location.start.column - 1,
--           end_lnum = decoded.location['end'].line - 1,
--           end_col = decoded.location['end'].column - 1,
--           severity = vim.diagnostic.severity.INFO,
--           message = decoded.reason,
--         })
--       end
--       return diagnostics
--     end,
--   }
-- end

l.linters_by_ft = {
  go = { 'golangcilint' },
  lua = { 'selene' },
  markdown = { 'markdownlint' },
  sql = { 'sqlfluff' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
  -- perl = { 'perlimports' },
}

return {}
