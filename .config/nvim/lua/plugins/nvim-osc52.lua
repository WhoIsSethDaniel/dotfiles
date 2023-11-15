require('osc52').setup {
  max_length = 0, -- Maximum length of selection (0 for no limit)
  silent = false, -- Disable message on successful copy
  trim = false, -- Trim surrounding whitespaces before copy
  tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
}

-- use osc 52 for clipboard, if remote.
-- NOTE: pasting does not work with wezterm (https://github.com/wez/wezterm/issues/3979#issuecomment-1634374139)
-- potential other tests:
-- - non-existence of $WAYLAND_DISPLAY -- session is (likely) remote
if vim.env.SSH_CONNECTION then
  local osc52_ok, osc52 = pcall(require, 'osc52')
  if osc52_ok then
    local function copy(lines, _)
      osc52.copy(table.concat(lines, '\n'))
    end

    local function paste()
      return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
    end

    vim.g.clipboard = {
      name = 'nvim-osc52',
      copy = { ['+'] = copy, ['*'] = copy },
      paste = { ['+'] = paste, ['*'] = paste },
    }
  elseif vim.fn.has 'nvim-0.10.0' == 1 then
    vim.g.clipboard = {
      name = 'native OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy,
        ['*'] = require('vim.ui.clipboard.osc52').copy,
      },
      paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste,
        ['*'] = require('vim.ui.clipboard.osc52').paste,
      },
    }
  end
end
