local configs = require 'lspconfig.configs'
configs['perlnavigator'] = {
  default_config = {
    root_dir = function(fname)
      return require('lspconfig').util.find_git_ancestor(fname)
    end,
    filetypes = { 'perl' },
    settings = {},
  },
}

return {
  cmd = { 'node', '/home/sdaniel_maxmind_com/src/PerlNavigator/server/out/server.js', '--stdio' },
  settings = {
    perlnavigator = {
      perlPath = '/usr/local/bin/mm-perl',
      perlcriticProfile = '/home/sdaniel_maxmind_com/src/work/mm_website/.perlcriticrc',
      perltidyProfile = '/home/sdaniel_maxmind_com/src/work/mm_website/perltidyrc',
    },
  },
}
