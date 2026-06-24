-- https://github.com/bscan/PerlNavigator
return {
  settings = {
    perlnavigator = {
      perlPath = 'perl',
      perlimportsLintEnabled = false,
      perlimportsTidyEnabled = true,
      perltidyEnabled = true,
      enableProgress = true,
      -- perlcriticProfile = '$workspaceFolder/.perlcriticrc',
      -- perltidyProfile = '$workspaceFolder/.perltidyallrc',
      -- logging = true,
    },
  },
  before_init = function(_, new_config)
    local m = string.match(vim.fn.getcwd(), '^(.*/work)')
    if m then
      if vim.fn.executable 'mm-perl' == 1 then
        new_config.settings.perlnavigator.perlPath = 'mm-perl'
      else
        new_config.settings.perlnavigator.perlPath = 'perl'
      end
      new_config.settings.perlnavigator.perlcriticProfile = table.concat({ m, 'mm_website/.perlcriticrc' }, '/')
      new_config.settings.perlnavigator.perltidyProfile = table.concat({ m, 'mm_website/.perltidyallrc' }, '/')
    end
  end,
}
