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
    local m = string.match(new_root, '^(.*mm_website)')
    if m then
      new_config.settings.perl.perltidyrc = path.concat { m, 'perltidyrc' }
    end
  end,
}
