-- https://github.com/echasnovski/mini.notify
local mn = require 'mini.notify'
mn.setup {
  -- Content management
  content = {
    -- Function which formats the notification message
    -- By default prepends message with notification time
    format = function(n)
      return string.format('%s', n.msg)
    end,

    -- Function which orders notification array from most to least important
    -- By default orders first by level and then by update timestamp
    sort = nil,
  },

  -- Notifications about LSP progress
  lsp_progress = {
    -- Whether to enable showing
    enable = true,

    -- Duration (in ms) of how long last message should be shown
    duration_last = 1000,
  },

  -- Window options
  window = {
    -- Floating window config
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
      return {
        anchor = 'SE',
        col = vim.o.columns,
        row = vim.o.lines - pad,
        border = 'none',
      }
    end,

    -- Maximum window width as share (between 0 and 1) of available columns
    max_width_share = 0.382,

    -- Value of 'winblend' option
    winblend = 25,
  },
}

vim.notify = mn.make_notify()

vim.keymap.set('n', '<leader>mm', function()
  local buf
  for _, id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[id].filetype == 'mininotify-history' then
      buf = id
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(w) == id then
          vim.api.nvim_win_close(w, true)
          return
        end
      end
      break
    end
  end

  if buf == nil then
    buf = vim.api.nvim_create_buf(true, true)
    vim.bo[buf].filetype = 'mininotify-history'
  end
  local notif_arr = mn.get_all()
  table.sort(notif_arr, function(a, b)
    return a.ts_update < b.ts_update
  end)
  local msgs = {}
  for _, mm in ipairs(notif_arr) do
    table.insert(msgs, mm.msg)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, msgs)
  local current = vim.api.nvim_get_current_win()
  vim.cmd(string.format('%s %s %d%s', 'vertical', 'rightbelow', 120, 'vnew'))
  local win = vim.api.nvim_get_current_win()
  vim.fn.win_gotoid(current)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
end, { noremap = true, silent = true })
