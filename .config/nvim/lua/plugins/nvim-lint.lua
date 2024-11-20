-- https://github.com/mfussenegger/nvim-lint
local l = require 'lint'

-- don't use VimEnter for try_lint as this monkeys-up the terminal checks for the
-- osc52 provider; use BufReadPost instead.
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
table.remove(sf.args)
table.insert(sf.args, '--dialect=postgres')

local eug = l.linters.eugene
table.insert(eug.args, '--sort-mode=name')
table.insert(eug.args, '--ignore=E4')

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

local golint = l.linters.golangcilint
golint.ignore_exitcode = false
table.insert(golint.args, 2, '--issues-exit-code=0')

local vint = l.linters.vint
vint.ignore_exitcode = false

l.linters_by_ft = {
  go = { 'golangcilint' },
  lua = { 'selene' },
  markdown = { 'markdownlint-cli2' },
  -- perlnavigator runs perlcritic
  -- perl = { 'perlcritic' },
  -- bashls runs shellcheck
  -- sh = { 'shellcheck' },
  sql = { 'sqlfluff', 'eugene' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
}

for ft, _ in pairs(l.linters_by_ft) do
  local linters = l.linters_by_ft[ft]

  -- add 'typos' for all defined filetypes
  table.insert(linters, 'typos')

  for _, linter in ipairs(linters) do
    local ns = l.get_namespace(linter)

    -- for golangcilint prepend the internal linter name to diagnostic message;
    -- otherwise just prepend the name of the linter
    vim.diagnostic.config({
      virtual_text = {
        format = function(d)
          local name = linter == 'golangcilint' and d.source or linter
          return string.format('%s: %s', name, d.message)
        end,
      },
    }, ns)

    -- do not ignore the exit code
    -- l.linters[linter].ignore_exitcode = false
  end
end
