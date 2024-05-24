-- https://github.com/mfussenegger/nvim-lint
local l = require 'lint'

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'BufEnter' }, {
  pattern = { '*' },
  callback = function()
    l.try_lint()
  end,
})

local mdl2 = l.linters['markdownlint-cli2']
mdl2.args = {
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
-- sel.ignore_exitcode = false
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

l.linters_by_ft = {
  go = { 'golangcilint' },
  lua = { 'selene' },
  markdown = { 'markdownlint-cli2' },
  sql = { 'sqlfluff' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
}

for ft, _ in pairs(l.linters_by_ft) do
  table.insert(l.linters_by_ft[ft], 'typos')
end
