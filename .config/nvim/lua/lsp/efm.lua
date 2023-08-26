local perltidy = require 'efmls-configs.formatters.perltidy'
local perlimports = require 'efmls-configs.formatters.perlimports'

local langs = {
  perl = { perltidy, perlimports },
}

return {
  filetypes = vim.tbl_keys(langs),
  settings = {
    rootMarkers = { '.git/' },
    languages = langs,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
