-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-git.md
require('mini.git').setup {
  command = {
    split = 'vertical',
  },
}

vim.api.nvim_set_hl(0, 'GitBlameHashRoot', { link = 'Tag' })
vim.api.nvim_set_hl(0, 'GitBlameHash', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'GitBlameAuthor', { link = 'String' })
vim.api.nvim_set_hl(0, 'GitBlameDate', { link = 'Comment' })

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniGitCommandSplit',
  callback = function(e)
    if e.data.git_subcommand ~= 'blame' then
      return
    end
    local win_src = e.data.win_source
    local buf = e.buf
    local win = e.data.win_stdout
    -- Opts
    vim.bo[buf].modifiable = false
    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    -- View
    vim.fn.winrestview { topline = vim.fn.line('w0', win_src) }
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })
    vim.wo[win].scrollbind, vim.wo[win_src].scrollbind = true, true
    vim.wo[win].cursorbind, vim.wo[win_src].cursorbind = true, true
    -- Vert width
    if e.data.cmd_input.mods == 'vertical' then
      local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
      local width = vim.iter(lines):fold(-1, function(acc, ln)
        local stat = string.match(ln, '^(.*%s+%d+%))%s+')
        return math.max(acc, vim.fn.strwidth(stat))
      end)
      width = width + vim.fn.getwininfo(win)[1].textoff
      vim.api.nvim_win_set_width(win, width)
    end
    -- Highlight
    vim.fn.matchadd('GitBlameHashRoot', [[^^\w\+]])
    vim.fn.matchadd('GitBlameHash', [[^\w\+]])
    local leftmost = [[^.\{-}\zs]]
    vim.fn.matchadd('GitBlameAuthor', leftmost .. [[(\zs.\{-} \ze\d\{4}-]])
    vim.fn.matchadd('GitBlameDate', leftmost .. [[[0-9-]\{10} [0-9:]\{8} +\d\+]])
  end,
})
