-- cache modules
vim.cmd [[ packadd! impatient.nvim ]]
require 'impatient'

-- an interesting discussion about options
-- https://www.reddit.com/r/vim/comments/gczg99/what_are_some_essential_but_not_obvious_set_opts/
--
-- when writing to registers A-Z append with a leading <CR>
vim.opt.cpoptions:append '>'

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
-- turn off vim match paren (this is done by the matchup plugin, too)
-- let loaded_matchparen = 1

-- recursive find; may want to change at some point (see above reddit link)
vim.opt.path = { ',', '**' }

-- use spaces instead of tabs
vim.opt.expandtab = true

-- how many spaces to move when <tab> is pressed
vim.opt.tabstop = 4

-- spaces when << or >> are used
vim.opt.shiftwidth = 4

-- use spaces when tab used at front of line
vim.opt.smarttab = true

-- only add one space when joining
vim.opt.joinspaces = false
-- keep wrapped lines at same indent level
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:2'

-- use sleuth instead
-- vim.opt.softtabstop = true

-- autoformatting (gw/gq); consider 120
vim.opt.textwidth = 120

-- do not automatically change directory (use rooter instead)
vim.opt.autochdir = false

-- do not automatically equalize window sizes
vim.opt.equalalways = false
-- where to place new windows by default
vim.opt.splitbelow = false
vim.opt.splitright = true

-- no error bells
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = 'all'

-- how gw/gq work
-- t: autowrap text using textwidth
-- c: autowrap comments
-- q: allow formatting of comments with gq
-- j: remove comment leader when it makes sense; set by sensible
-- n: recognize numbered lists; uses formatlistpat
vim.opt.formatoptions = 'tcqjn'

-- 'enhanced' command-line completion (sensible turns this on)
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
vim.opt.smartindent = true
-- follow previous line's indent
vim.opt.autoindent = true

-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
-- reduce from default (1000)
vim.opt.undolevels = 500
vim.opt.history = 10000

--  swap and backup files
vim.opt.directory = vim.env.XDG_DATA_HOME .. '/nvim/swap'
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- typing
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50

-- below is the default
-- vim.opt.backspace = { "indent", "eol", "start" }

-- show the command being typed
vim.opt.showcmd = true

-- show the cursorline
vim.opt.cursorline = true

-- ignore modelines
vim.opt.modeline = true
vim.opt.modelines = 0

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
vim.opt.sessionoptions:append 'resize,winpos,terminal'

-- terminal
-- scroll buffer; 100000 is the max
vim.opt.scrollback = 100000
-- vim.opt.scrolloff = 25

-- commented out: use telescope instead
-- use rg for grep
-- vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
-- vim.opt.grepformat = { '%f:%l:%c:%m', '%f:%l:%m' }
-- vim.api.nvim_command 'command -nargs=* Grep silent! grep! <args> | cwindow | redraw!'

-- color scheme -- set actual scheme in colorscheme.vim
vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- configuration for completion
vim.opt.complete = { '.', 'w', 'b', 'u' }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }

-- messages
-- I: turn off vim 'intro' message
-- S: turn off search stats
-- c: turn off menu messages
-- s: turn off "search hit BOTTOM, continuing at TOP" message during search
vim.opt.shortmess:append 'Ics'

-- use the patience algorithm when diffing; perhaps also try 'histogram';
-- default algorithm is myers
vim.opt.diffopt:append { 'algorithm:patience' }

-- use filetype.lua instead of filetype.vim
if vim.fn.has 'nvim-0.7' == 1 then
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0

  vim.cmd [[
  if exists('did_load_filetypes')
    augroup filetypedetect
    au BufRead,BufNewFile * if !did_filetype() && expand('<amatch>') !~ g:ft_ignore_pat | runtime! scripts.vim | endif
    au StdinReadPost * if !did_filetype() | runtime! scripts.vim | endif
    augroup END
  endif
  ]]

  -- add perl module filetype (pm)
  vim.filetype.add {
    extension = {
      pm = function(path, bufnr)
        if vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]:find 'XPM2' then
          return 'xpm2'
        elseif vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]:find 'XPM' then
          return 'xpm'
        else
          return 'perl'
        end
      end,
      t = 'perl',
    },
  }
end

-- turn on embedded highlighting for lua
--   perhaps not relevant with treesitter
-- vim.g.vimsyn_embed = 'l'

-- Disable a bunch of unused, builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_zip = 1
vim.g.loaded_gzip = 1
-- vim.g.loaded_man = 1
-- matchup wants to load matchparen
-- vim.g.loaded_matchparen = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
-- make certain the matchit plugin is not loaded (per the matchup documentation matchit should not be loaded)
vim.g.loaded_matchit = 1

-- \ is the default
vim.g.mapleader = ' '
-- vim.g.maplocalleader = '\'

-- key mappings
-- vim.api.nvim_set_keymap("n", "<leader>wt", ":new<cr><C-W>L:terminal<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wo', '<C-W>v:enew<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ev', ':edit $MYVIMRC<cr>', { silent = true, noremap = true })
-- correctly paste from the * or + register (possibly others too) when using c_<C-R>
-- see: https://vi.stackexchange.com/questions/25311/how-to-activate-bracketed-paste-mode-in-gnome-terminal-for-vim-inside-tmux/25315#25315
vim.api.nvim_exec([[ ino <expr> <c-r> getregtype(v:register) =~# '<c-v>' ? '<c-r>' : '<c-r><c-o>' ]], false)

-- autocommands
require 'autocmd'

-- comands
require 'commands'

-- source all plugins and their custom config
require 'all'
