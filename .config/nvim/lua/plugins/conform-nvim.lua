--# selene: allow(mixed_table)
-- https://github.com/stevearc/conform.nvim
local c = require 'conform'

c.formatters.shfmt = {
  prepend_args = { '-i=4', '-ci', '-s', '-bn' },
}

c.formatters.golines = {
  prepend_args = { '--shorten-comments' },
}

c.formatters.gci = {
  prepend_args = { '-s=standard', '-s=default', '-s=prefix(github.maxmind.com/maxmind/mm_website' },
}

c.formatters.prettier = function(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local m = string.match(bufname, '^(.*/work)')
  if m then
    return {
      prepend_args = {
        string.format('--config=%s/mm_website/.prettierrc.non-js.cjs', m),
      },
      cwd = function()
        return string.format('%s/mm_website', m)
      end,
    }
  end
end

local disable_by_type = {}
vim.api.nvim_create_user_command('FormatCtl', function(args)
  if #args.fargs == 0 then
    if vim.g.disable_formatting then
      vim.g.disable_formatting = false
      print 'turning formatting on globally'
    else
      vim.g.disable_formatting = true
      print 'turning formatting off globally'
    end
  elseif #args.fargs == 1 then
    local cmd = args.fargs[1]
    if cmd == 'buf' then
      if vim.b.disable_formatting then
        vim.b.disable_formatting = false
        print 'turning formatting on for buffer'
      else
        vim.b.disable_formatting = true
        print 'turning formatting off for buffer'
      end
    elseif cmd == 'ft' then
      local ft = vim.bo.filetype
      if disable_by_type[ft] then
        disable_by_type[ft] = false
        print('turning formatting on for ' .. ft .. ' files')
      else
        disable_by_type[ft] = true
        print('turning formatting off for ' .. ft .. ' files')
      end
    end
  end
end, {
  complete = function()
    return { 'buf', 'ft' }
  end,
  nargs = '*',
})

local should_format = function(b, ft)
  if vim.g.disable_formatting or vim.b[b].disable_formatting or disable_by_type[ft] then
    return false
  end
  return true
end

c.setup {
  log_level = vim.log.levels.DEBUG,
  notify_on_error = true,
  notify_no_formatters = true,
  default_format_opts = {
    timeout_ms = 1000,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    go = { 'golangci-lint', lsp_format = 'fallback' },
    gohtml = { 'prettier' },
    gotmpl = { 'prettier' },
    json = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier', 'injected' },
    -- use perlnavigator
    -- perl = { 'perltidy', 'perlimports' },
    query = { 'format-queries' },
    -- bashls uses 'shfmt' for formatting
    sh = { 'shellharden', lsp_format = 'last' },
    -- if the dprint lsp server isn't running try the cli
    toml = { 'dprint', lsp_format = 'prefer' },
    yaml = { 'prettier' },
  },
  -- don't use format_on_save for now
  format_on_save = nil,
  format_after_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    if not should_format(bufnr, ft) then
      return
    elseif ft == 'perl' then
      return { lsp_format = 'prefer' }
    end
    return {}
  end,
}
