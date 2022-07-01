local cmp = require 'cmp'
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
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
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
    { name = 'nvim_lsp_signature_help', priority = 10 },
    { name = 'vsnip', priority = 8 },
  },
  -- preselect = cmp.PreselectMode.Item,
  preselect = cmp.PreselectMode.None,
  view = {
    -- entries = 'native',
  },
  experimental = {
    ghost_text = true,
  },
}

-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources {
--     { name = 'nvim_lsp_document_symbol' },
--     { name = 'buffer' },
--   },
-- })

-- bug
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources {
--     { name = 'cmdline', keyword_length = 2 },
--     { name = 'nvim_lua' },
--     { name = 'path' },
--   },
-- })
