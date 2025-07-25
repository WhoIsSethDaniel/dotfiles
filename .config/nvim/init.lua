-- cache modules
vim.loader.enable()

--
-- an interesting discussion about options
-- https://www.reddit.com/r/vim/comments/gczg99/what_are_some_essential_but_not_obvious_set_opts/
--

-- when writing to registers A-Z append with a leading <CR>
vim.opt.cpoptions:append '>'

-- turn off mouse support
vim.o.mouse = ''
vim.o.mousescroll = 'hor:0,ver:0'

-- unicode emojis are not always considered full width
vim.o.emoji = false

-- make certain folding is turned off
vim.o.foldenable = false

-- ignore case in search patterns;
-- can be overridden using \C
vim.o.ignorecase = true

-- override the ignorecase option IFF the search pattern contains upper-case characters
vim.o.smartcase = true

-- highlight all matches for the most recent search
vim.o.hlsearch = true

-- show search matches as it is being typed
vim.o.incsearch = true

-- show the results of :sub immediately
vim.o.inccommand = 'nosplit'

-- automatically write the file/buffer in certain circumstances
vim.o.autowrite = true
-- vim.o.autowriteall = true

-- show matching pairs of brackets (see 'matchpairs' option for
-- setting new pairs / removing unwanted pairs)
vim.o.showmatch = true

-- recursive find; may want to change at some point (see above reddit link)
vim.opt.path = { ',', '**' }

-- USE editorconfig instead of following few settings
-- use spaces instead of tabs
-- vim.o.expandtab = true

-- how many spaces to move when <tab> is pressed
-- vim.o.tabstop = 4

-- spaces when << or >> are used
-- vim.o.shiftwidth = 4

-- use spaces when tab used at front of line
-- vim.o.smarttab = true
--
-- vim.o.softtabstop = 4

-- autoformatting (gw/gq)
-- vim.o.textwidth = 120
-- END editorconfig

-- use conform
-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- only add one space when joining
vim.o.joinspaces = false
-- keep wrapped lines at same indent level
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:2'

-- do not automatically change directory (use project.nvim instead)
vim.o.autochdir = false

-- do not automatically equalize window sizes
vim.o.equalalways = false
-- where to place new windows by default
vim.o.splitbelow = false
vim.o.splitright = true
-- cursor position when splitting
vim.o.splitkeep = 'screen'

-- no error bells
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.belloff = 'all'

-- how gw/gq work
-- t: autowrap text using textwidth
-- c: autowrap comments
-- r: autoinsert comment leader
-- q: allow formatting of comments with gq
-- j: remove comment leader when it makes sense; set by sensible
-- n: recognize numbered lists; uses formatlistpat
vim.o.formatoptions = 'tcrqjno'

-- 'enhanced' command-line completion (sensible turns this on)
-- [not needed or used when using cmp-cmdline]
vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,full'
-- case insensitive file matching
-- vim.o.fileignorecase = true
-- case insensitive file completion
-- vim.o.wildignorecase = true

-- relative line numbers, but with the current line number displayed
vim.o.number = true
vim.o.relativenumber = true
-- width granted to line numbers (default is 4)
vim.o.numberwidth = 4

-- turn on indenting
-- ** use treesitter.indent instead
-- vim.o.smartindent = true
-- follow previous line's indent (on by default)
-- vim.o.autoindent = true

-- undo
vim.o.undofile = true
-- vim.o.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
-- reduce from default (1000)
vim.o.undolevels = 500
-- cannot be larger than 10000
vim.o.history = 10000

-- swap and backup files
-- vim.o.directory = vim.env.XDG_DATA_HOME .. '/nvim/swap//'
-- disable swap
vim.o.directory = ''
-- vim.o.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- typing
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

-- below is the default
-- vim.o.backspace = { "indent", "eol", "start" }

-- show the command being typed
vim.o.showcmd = true

-- show the cursorline
vim.o.cursorline = true

-- Modelines are needed when setting ft=help for plugin help files.
-- See section below re: setting filetype for plugin help files.
vim.o.modeline = false
-- default is 5 -- ignored if 'modeline' is false
-- vim.o.modelines = 1

-- turn on/off the sign column
vim.o.signcolumn = 'yes'

-- preview window / popup
vim.o.previewheight = 10

-- buffer control; usetab = use already open buffer(s) or tab(s), if possible, when switching tabs
vim.o.switchbuf = 'usetab'

-- session and shada
-- default is `100,<50,s10,h
vim.opt.shada = { "'250", '<50', 's250', 'h' }
-- NO NO -- vim.o.shada:append("%")  -- store all open buffers
-- default is blank,buffers,curdir,folds,help,tabpages,winsize
-- vim.o.sessionoptions:append 'terminal'
-- vim.o.sessionoptions:remove 'buffers'
-- vim.o.sessionoptions:remove 'winsize'
-- vim.o.sessionoptions:remove 'blank'

-- terminal
-- scroll buffer; 100000 is the max
vim.o.scrollback = 100000
-- default is 0 for scrolloff
-- vim.o.scrolloff = 25

-- commented out: use telescope instead
-- use rg for grep
-- vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
-- vim.o.grepformat = { '%f:%l:%c:%m', '%f:%l:%m' }
-- vim.api.nvim_command 'command -nargs=* Grep silent! grep! <args> | cwindow | redraw!'

-- color scheme
-- this should be set to true by default if the host terminal supports it
-- vim.o.termguicolors = true
vim.o.background = 'dark'

-- configuration for completion
-- [not necessary with nvim-cmp]
vim.opt.complete = { '.', 'w', 'b', 'u' }
-- vim.o.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }

-- messages
-- I: turn off vim 'intro' message
-- S: turn off search stats
-- c: turn off menu messages
-- s: turn off "search hit BOTTOM, continuing at TOP" message during search
vim.opt.shortmess:append 'Ics'

-- use the patience algorithm when diffing; perhaps also try 'histogram';
-- default algorithm is myers
vim.opt.diffopt:append { 'algorithm:patience', 'linematch:60', 'vertical' }

-- unneeded with a statusline
vim.o.showmode = false

-- thicker borders when using global statusline
vim.opt.fillchars:append {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
}

vim.o.laststatus = 3

-- command-line is not visible if not entering a command
vim.o.cmdheight = 0

-- set the border style for floating windows
vim.o.winborder = 'none'

-- maybe turn off 'hit-enter' message; have insane history
-- vim.o.messagesopt = { 'wait:0', 'history:10000' }
vim.opt.messagesopt = { 'hit-enter', 'history:10000' }

-- this is needed for lemonade
-- vim.o.clipboard = 'unnamedplus'

-- allow placing the entered command in the statusline
-- (lualine doesn't support this yet)
-- if vim.fn.has 'nvim-0.9.0' == 1 then
-- vim.o.showcmdloc = 'statusline'
-- end

-- turn on embedded highlighting for lua
--   perhaps not relevant with treesitter
-- vim.g.vimsyn_embed = 'l'

-- Disable a bunch of unused, builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
-- vim.g.loaded_man = 1
-- matchup wants to load matchparen
-- vim.g.loaded_matchparen = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
-- make certain the matchit plugin is not loaded (per the matchup documentation matchit should not be loaded)
vim.g.loaded_matchit = 1
-- turn off un-needed language providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- \ is the default
vim.g.mapleader = ' '
-- vim.g.maplocalleader = '\'

-- make healthcheck floating
vim.g.health = { style = 'float' }

-- key mappings
local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>wo', '<C-W>v:enew<cr>', opts)
-- close any open help window
vim.keymap.set('n', '<leader>ch', function()
  local bufs = vim.api.nvim_list_bufs()
  for _, b in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_get_option_value('filetype', { buf = b }) == 'help' then
      vim.api.nvim_buf_delete(b, { force = true })
    end
  end
end, opts)
-- toggle showing/hiding the diagnostics
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- correctly paste from the * or + register (possibly others too) when using c_<C-R>
-- see: https://vi.stackexchange.com/questions/25311/how-to-activate-bracketed-paste-mode-in-gnome-terminal-for-vim-inside-tmux/25315#25315
-- unclear if this is required for wezterm or anything other than gnome terminal
-- vim.api.nvim_exec([[ ino <expr> <c-r> getregtype(v:register) =~# '<c-v>' ? '<c-r>' : '<c-r><c-o>' ]], false)

-- find all non git files within the pwd and place them in args
vim.cmd [[ command! -nargs=0 LoadAll :args `fdfind --type f --exclude .git -c never -H`<cr> ]]

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end

-- filetypes
vim.filetype.add {
  extension = {
    gohtml = 'gohtml',
  },
  pattern = {
    ['.*/ssh/config'] = {
      'sshconfig',
      { priority = -math.huge },
    },
    -- see 'modeline' and 'modelines' setting above. If 'modelines'
    -- is set to 0 or 'modeline' is turned off the following should
    -- be uncommented for plugin help files to be identified properly --
    -- but not always -- not all help files have modelines, so this
    -- should stay uncommented.
    ['.*/doc/.*%.txt'] = function(path)
      for _, p in ipairs(vim.opt.rtp:get()) do
        if string.match(path, p .. '.*/doc.*%.txt') ~= nil then
          return 'help'
        end
      end
      return nil
    end,
  },
}

-- global diagnostic options
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  signs = function()
    local icons = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
    return {
      text = {
        [vim.diagnostic.severity.ERROR] = icons['Error'],
        [vim.diagnostic.severity.WARN] = icons['Warn'],
        [vim.diagnostic.severity.HINT] = icons['Hint'],
        [vim.diagnostic.severity.INFO] = icons['Info'],
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.HINT] = '',
        [vim.diagnostic.severity.INFO] = '',
      },
    }
  end,
}

_G.notify = function(msg, lvl)
  lvl = lvl or vim.log.levels.INFO
  vim.schedule(function()
    vim.notify(msg, lvl)
  end)
end

-- turn off deprecation notices
-- if vim.fn.has 'nvim-0.12.0' == 1 then
--   vim.deprecate = function() end
-- end

-- source all plugins and their custom config (if any)
require 'all'

-- autocommands
require 'autocmd'

-- lsp setup
require('plugins.lsp').setup()
