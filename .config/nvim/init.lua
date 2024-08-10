-- cache modules
if vim.fn.has 'nvim-0.9.0' == 1 then
  vim.loader.enable()
end

--
-- an interesting discussion about options
-- https://www.reddit.com/r/vim/comments/gczg99/what_are_some_essential_but_not_obvious_set_opts/
--

-- when writing to registers A-Z append with a leading <CR>
vim.opt.cpoptions:append '>'

-- turn off mouse support
vim.opt.mouse = ''
vim.opt.mousescroll = 'hor:0,ver:0'

-- unicode emojis are not always considered full width
vim.opt.emoji = false

-- make certain folding is turned off
vim.opt.foldenable = false

-- ignore case in search patterns;
-- can be overridden using \C
vim.opt.ignorecase = true

-- override the ignorecase option IFF the search pattern contains upper-case characters
vim.opt.smartcase = true

-- highlight all matches for the most recent search
vim.opt.hlsearch = true

-- show search matches as it is being typed
vim.opt.incsearch = true

-- show the results of :sub immediately
vim.opt.inccommand = 'nosplit'

-- automatically write the file/buffer in certain circumstances
vim.opt.autowrite = true
-- vim.opt.autowriteall = true

-- show matching pairs of brackets (see 'matchpairs' option for
-- setting new pairs / removing unwanted pairs)
vim.opt.showmatch = true

-- recursive find; may want to change at some point (see above reddit link)
vim.opt.path = { ',', '**' }

-- USE editorconfig instead of following few settings
-- use spaces instead of tabs
-- vim.opt.expandtab = true

-- how many spaces to move when <tab> is pressed
-- vim.opt.tabstop = 4

-- spaces when << or >> are used
-- vim.opt.shiftwidth = 4

-- use spaces when tab used at front of line
-- vim.opt.smarttab = true
--
-- vim.opt.softtabstop = 4

-- autoformatting (gw/gq)
-- vim.opt.textwidth = 120
-- END editorconfig

-- only add one space when joining
vim.opt.joinspaces = false
-- keep wrapped lines at same indent level
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:2'

-- do not automatically change directory (use project.nvim instead)
vim.opt.autochdir = false

-- do not automatically equalize window sizes
vim.opt.equalalways = false
-- where to place new windows by default
vim.opt.splitbelow = false
vim.opt.splitright = true
-- cursor position when splitting
if vim.fn.has 'nvim-0.9.0' == 1 then
  vim.opt.splitkeep = 'screen'
end

-- no error bells
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = 'all'

-- how gw/gq work
-- t: autowrap text using textwidth
-- c: autowrap comments
-- r: autoinsert comment leader
-- q: allow formatting of comments with gq
-- j: remove comment leader when it makes sense; set by sensible
-- n: recognize numbered lists; uses formatlistpat
vim.opt.formatoptions = 'tcrqjno'

-- 'enhanced' command-line completion (sensible turns this on)
-- [not needed or used when using cmp-cmdline]
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
-- case insensitive file matching
-- vim.opt.fileignorecase = true
-- case insensitive file completion
-- vim.opt.wildignorecase = true

-- relative line numbers, but with the current line number displayed
vim.opt.number = true
vim.opt.relativenumber = true
-- width granted to line numbers (default is 4)
vim.opt.numberwidth = 4

-- turn on indenting
-- ** use treesitter.indent instead
-- vim.opt.smartindent = true
-- follow previous line's indent (on by default)
-- vim.opt.autoindent = true

-- undo
vim.opt.undofile = true
-- vim.opt.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
-- reduce from default (1000)
vim.opt.undolevels = 500
-- cannot be larger than 10000
vim.opt.history = 10000

-- swap and backup files
-- vim.opt.directory = vim.env.XDG_DATA_HOME .. '/nvim/swap//'
-- disable swap
vim.opt.directory = ''
-- vim.opt.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- typing
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50

-- below is the default
-- vim.opt.backspace = { "indent", "eol", "start" }

-- show the command being typed
vim.opt.showcmd = true

-- show the cursorline
vim.opt.cursorline = true

-- Modelines are needed when setting ft=help for plugin help files.
-- See section below re: setting filetype for plugin help files.
vim.opt.modeline = false
-- default is 5 -- ignored if 'modeline' is false
-- vim.opt.modelines = 1

-- turn on/off the sign column
vim.opt.signcolumn = 'yes'

-- preview window / popup
vim.opt.previewheight = 10

-- buffer control; usetab = use already open buffer(s) or tab(s), if possible, when switching tabs
vim.opt.switchbuf = 'usetab'

-- session and shada
-- default is `100,<50,s10,h
vim.opt.shada = { "'250", '<50', 's250', 'h' }
-- NO NO -- vim.opt.shada:append("%")  -- store all open buffers
-- default is blank,buffers,curdir,folds,help,tabpages,winsize
-- vim.opt.sessionoptions:append 'terminal'
-- vim.opt.sessionoptions:remove 'buffers'
-- vim.opt.sessionoptions:remove 'winsize'
-- vim.opt.sessionoptions:remove 'blank'

-- terminal
-- scroll buffer; 100000 is the max
vim.opt.scrollback = 100000
-- default is 0 for scrolloff
-- vim.opt.scrolloff = 25

-- commented out: use telescope instead
-- use rg for grep
-- vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
-- vim.opt.grepformat = { '%f:%l:%c:%m', '%f:%l:%m' }
-- vim.api.nvim_command 'command -nargs=* Grep silent! grep! <args> | cwindow | redraw!'

-- color scheme
-- this should be set to true by default if the host terminal supports it
-- vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- configuration for completion
-- [not necessary with nvim-cmp]
vim.opt.complete = { '.', 'w', 'b', 'u' }
-- vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }

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
vim.opt.showmode = false

-- thicker borders when using global status bar
vim.opt.fillchars:append {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
}

-- command-line is not visible if not entering a command
vim.opt.cmdheight = 0

-- this is needed for lemonade
-- vim.opt.clipboard = 'unnamedplus'

-- allow placing the entered command in the statusline
-- (lualine doesn't support this yet)
-- if vim.fn.has 'nvim-0.9.0' == 1 then
-- vim.opt.showcmdloc = 'statusline'
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

-- key mappings
local opts = { silent = true, noremap = true }
local map = vim.keymap.set
map('n', '<leader>dq', vim.diagnostic.setqflist, opts)
map('n', '<leader>dl', vim.diagnostic.setloclist, opts)
map('n', '<leader>wo', '<C-W>v:enew<cr>', opts)
-- close any open help window
map('n', '<leader>ch', function()
  local bufs = vim.api.nvim_list_bufs()
  for _, b in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_get_option_value('filetype', { buf = b }) == 'help' then
      vim.api.nvim_buf_delete(b, { force = true })
    end
  end
end, opts)
-- toggle showing/hiding the diagnostics
map(
  'n',
  '<leader>td',
  (function()
    local diag_status = 1 -- 1 is show; 0 is hide
    return function()
      if diag_status == 1 then
        diag_status = 0
        vim.diagnostic.hide()
      else
        diag_status = 1
        vim.diagnostic.show()
      end
    end
  end)()
)

-- correctly paste from the * or + register (possibly others too) when using c_<C-R>
-- see: https://vi.stackexchange.com/questions/25311/how-to-activate-bracketed-paste-mode-in-gnome-terminal-for-vim-inside-tmux/25315#25315
-- unclear if this is required for wezterm or anything other than gnome terminal
-- vim.api.nvim_exec([[ ino <expr> <c-r> getregtype(v:register) =~# '<c-v>' ? '<c-r>' : '<c-r><c-o>' ]], false)

-- find all non git files within the pwd and place them in args
vim.api.nvim_command [[ command! -nargs=0 LoadAll :args `fdfind --type f --exclude .git -c never -H`<cr> ]]

-- filetypes
vim.filetype.add {
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

-- lots of deprecation messages in nightly following 0.10 release.
if vim.fn.has 'nvim-0.11.0' == 1 then
  vim.deprecate = function() end
end

-- autocommands
require 'autocmd'

-- source all plugins and their custom config (if any)
require 'all'

-- lsp setup
require('plugins.lsp').setup()
