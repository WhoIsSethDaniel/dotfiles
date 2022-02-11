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
        luasnip = '[Lsnip]',
        buffer = '[Buf]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        calc = '[Calc]',
        emoji = '[Emoji]',
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
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'buffer', priority = 7, keyword_length = 4 },
    { name = 'emoji', priority = 3 },
    { name = 'path', priority = 5 },
    { name = 'calc', priority = 4 },
    { name = 'nvim_lua', priority = 9 },
    { name = 'nvim_lsp', priority = 9 },
    { name = 'nvim_lsp_signature_help', priority = 10 },
    { name = 'vsnip', priority = 8 },
  },
  view = {
    -- entries = 'native',
  },
  experimental = {
    ghost_text = true,
  },
}
