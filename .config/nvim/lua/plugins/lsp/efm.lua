-- https://github.com/mattn/efm-langserver
-- https://github.com/creativenull/efmls-configs-nvim
local perlcritic = require 'efmls-configs.linters.perlcritic'
local perlimports = require 'efmls-configs.formatters.perlimports'
local perltidy = require 'efmls-configs.formatters.perltidy'

local langs = {
  perl = { perltidy, perlimports, perlcritic },
}

return {
  -- cmd = { 'efm-langserver', '-logfile', '/home/seth/tmp/efm.log', '-loglevel', '100', '-q' },
  cmd = { 'efm-langserver' },
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
