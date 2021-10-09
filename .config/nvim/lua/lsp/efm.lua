-- https://github.com/mattn/efm-langserver
-- https://microsoft.github.io/language-server-protocol/specification.html#initialize
-- {
--     "init_options": {
--         "documentFormatting": true,
--         "hover": true,
--         "documentSymbol": true,
--         "codeAction": true,
--         "completion": true
--     }
-- }
return {
  filetypes = { 'sh', 'lua', 'json' },
  init_options = {
    documentFormatting = true,
    hover = false,
    documentSymbol = false,
    codeAction = false,
    completion = false
  },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      json = {
        {
          formatCommand = 'jq .',
          formatStdin = true,
        },
      },
      lua = {
        {
          formatCommand = 'stylua --search-parent-directories -',
          formatStdin = true,
        },
      },
      sh = {
        { formatCommand = 'shfmt -i 4 -ci -s -bn' },
      },
    },
  },
}
