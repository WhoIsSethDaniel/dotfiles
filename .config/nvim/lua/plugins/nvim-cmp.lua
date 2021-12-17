require('cmp_nvim_lsp').setup()

local cmp = require 'cmp'
cmp.setup {
  -- preselect = require'cmp.types'.cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', require('lspkind').presets.default[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snp]',
        buffer = '[Buf]',
        nvim_lua = '[Lua]',
        path = '[Pth]',
        calc = '[Clc]',
        emoji = '[Emj]',
        vsnip = '[Vsnip]',
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-j>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'buffer' },
    { name = 'emoji' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'cmdline' },
    -- { name = 'buffer' },
  },
}
