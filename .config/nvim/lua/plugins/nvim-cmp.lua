-- https://github.com/hrsh7th/nvim-cmp
-- https://www.reddit.com/r/neovim/comments/1bojtr0/please_share_your_nvimcmp_config/
-- * many examples of cmp being configured
-- https://github.com/nvim-lua/kickstart.nvim/blob/b529bc33590cbb81a5916408b2d6001a643e596c/init.lua#L619
-- * for snippets, perhaps: https://github.com/rafamadriz/friendly-snippets
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      vim_item = require('lspkind').cmp_format()(entry, vim_item)
      local alias = {
        buffer = 'buffer',
        path = 'path',
        calc = 'calc',
        emoji = 'emoji',
        nvim_lsp = 'LSP',
        luasnip = 'luasnip',
        vsnip = 'vsnip',
        nvim_lua = 'lua',
        nvim_lsp_signature_help = 'LSP Signature',
      }

      if entry.source.name == 'nvim_lsp' then
        vim_item.menu = entry.source.source.client.name
      else
        vim_item.menu = alias[entry.source.name] or entry.source.name
      end
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered { border = 'rounded' },
    documentation = cmp.config.window.bordered { border = 'rounded' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm { select = false },
  },
  sources = cmp.config.sources {
    { name = 'buffer', priority = 7, keyword_length = 4 },
    { name = 'emoji', priority = 3 },
    { name = 'path', priority = 5 },
    { name = 'calc', priority = 4 },
    { name = 'nvim_lua', priority = 9 },
    { name = 'nvim_lsp', priority = 9 },
    { name = 'luasnip', priority = 8 },
  },
  -- preselect = cmp.PreselectMode.Item,
  preselect = cmp.PreselectMode.None,
  view = {
    -- entries = 'native',
  },
  experimental = {
    ghost_text = true,
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
