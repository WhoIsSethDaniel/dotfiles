local path = require 'nvim-lsp-installer.path'

return {
  cmd = { 'pls' },
  settings = {
    perl = {
      perltidyrc = '.perltidyrc',
      perlcritic = { enabled = true },
    },
  },
  on_new_config = function(new_config, new_root)
    local m = string.match(new_root, '^(.*/work)')
    if m then
      new_config.settings.perl.perltidyrc = path.concat { m, 'mm_website/.perltidyallrc' }
    end
  end,
}
