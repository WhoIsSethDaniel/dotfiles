return {
  settings = {
    perlnavigator = {
      perlPath = 'perl',
    },
  },
  on_new_config = function(new_config, new_root)
    local m = string.match(new_root, '^(.*/work)')
    if m then
      new_config.settings.perlnavigator.perlPath = 'mm-perl'
      new_config.settings.perlnavigator.perlcriticProfile = table.concat({ m, 'mm_website/.perlcriticrc' }, '/')
      new_config.settings.perlnavigator.perltidyProfile = table.concat({ m, 'mm_website/.perltidyallrc' }, '/')
    end
  end,
}
