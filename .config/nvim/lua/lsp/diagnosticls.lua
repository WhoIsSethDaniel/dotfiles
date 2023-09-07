-- https://github.com/iamcco/diagnostic-languageserver
-- https://github.com/creativenull/diagnosticls-configs-nvim
local dlsconfig = require 'diagnosticls-configs'
local perlcritic = require 'diagnosticls-configs.linters.perlcritic'
local perlimports = require 'diagnosticls-configs.formatters.perlimports'
local perltidy = require 'diagnosticls-configs.formatters.perlimports'

dlsconfig.init()
dlsconfig.setup {
  perl = {
    formatter = {
      perlimports,
      perltidy,
    },
    linter = {
      perlcritic,
    },
  },
}
