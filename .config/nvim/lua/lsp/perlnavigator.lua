local path = require 'nvim-lsp-installer.path'

return {
  settings = {
    perlnavigator = {
      perlPath = 'perl',
    },
  },
  on_new_config = function(new_config, new_root)
    local m = string.match(new_root, '^(.*mm_website)')
    if m then
      new_config.settings.perlnavigator.perlPath = 'mm-perl'
      new_config.settings.perlnavigator.perlcriticProfile = path.concat { m, '.perlcriticrc' }
      new_config.settings.perlnavigator.perltidyProfile = path.concat { m, 'perltidyrc' }
    end
  end,
}
