-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/garymjr/nvim-snippets
-- https://www.reddit.com/r/neovim/comments/1bojtr0/please_share_your_nvimcmp_config/
-- * many examples of cmp being configured
-- https://github.com/LazyVim/LazyVim/blob/fba06ce9f522b91be8a342f9c028948c2733132d/lua/lazyvim/plugins/coding.lua
-- * lazyvim cmp config
-- https://github.com/nvim-lua/kickstart.nvim/blob/b529bc33590cbb81a5916408b2d6001a643e596c/init.lua#L619
-- * for snippets, perhaps: https://github.com/rafamadriz/friendly-snippets
local cmp = require 'cmp'
local snippets = require 'snippets'

snippets.setup {}
cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    format = require('lspkind').cmp_format {
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function(entry, vim_item)
      --   return vim_item
      -- end,
    },
  },
  window = {
    completion = cmp.config.window.bordered { border = 'rounded' },
    documentation = cmp.config.window.bordered { border = 'rounded' },
  },
  -- uses built-in vim.snippet.expand() by default
  -- snippet = {
  -- expand = function(args)
  --   luasnip.lsp_expand(args.body)
  -- end,
  -- },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ['<C-b>'] = cmp.mapping.scroll_docs(-5),
    ['<C-f>'] = cmp.mapping.scroll_docs(5),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-q>'] = cmp.mapping.abort(),
  },
  sources = cmp.config.sources {
    { name = 'buffer', priority = 7, keyword_length = 4 },
    { name = 'emoji', priority = 3 },
    { name = 'path', priority = 5 },
    { name = 'calc', priority = 4 },
    { name = 'nvim_lua', priority = 9 },
    { name = 'nvim_lsp', priority = 9 },
    { name = 'snippets', priority = 8 },
  },
  -- preselect = cmp.PreselectMode.Item,
  -- preselect = cmp.PreselectMode.None,
  view = {
    -- entries = 'native',
    entries = {
      follow_cursor = true,
    },
  },
  experimental = {
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
    native_menu = false,
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'cmdline', keyword_length = 2 },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
})
