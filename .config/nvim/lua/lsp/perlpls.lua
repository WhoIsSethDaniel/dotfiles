return {
  cmd = { 'pls' },
  settings = {
    perl = {
      perltidyrc = '.../.perltidyrc',
      perlcritic = { enabled = true },
    },
  },
  on_new_config = function(new_config, new_root)
    if string.match(new_root, 'mm_website') then
      new_config.settings.perl.perltidyrc = 'perltidyrc'
    end
  end,
}
