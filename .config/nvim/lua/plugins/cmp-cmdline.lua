local cmp = require 'cmp'

cmp.setup.cmdline('/', {
  sources = {
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline', keyword_length = 2 },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
})
