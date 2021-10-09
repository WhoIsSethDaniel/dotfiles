require('cmp_nvim_lsp').setup()

local cmp = require 'cmp'
cmp.setup {
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
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'buffer' },
    { name = 'emoji' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
  },
}
