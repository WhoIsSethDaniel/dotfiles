-- https://github.com/akinsho/toggleterm.nvim
require('toggleterm').setup {
  -- size can be a number or function which is passed the current terminal
  size = 120,
  open_mapping = [[<C-t>]],
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  shading_ratio = -3,
  start_in_insert = false,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true,
  persist_size = false,
  persist_mode = false,
  direction = 'vertical',
  close_on_exit = true, -- close the terminal window when the process exits
  clear_env = false,
  auto_scroll = true,
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'single',
    width = 100,
    height = 20,
    winblend = 3,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end,
  },
  responsiveness = {
    -- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
    -- instead of next to each other
    -- default = 0 which means the feature is turned off
    horizontal_breakpoint = 135,
  },
}

-- fix <s-space> problem (for now)
-- https://www.reddit.com/r/neovim/comments/1340ttr/issue_with_terminal_and_recent_wezterm/
-- https://github.com/vim/vim/issues/6040
-- vim.keymap.set('t', '<s-space>', '<space>', { noremap = true, silent = true, desc = 'toggleterm wezterm fix' })
