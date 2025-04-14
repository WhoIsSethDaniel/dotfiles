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
  before_init = function(params, new_config)
    local m = string.match(vim.fn.getcwd(), '^(.*/work)')
    if m then
      new_config.settings.perlnavigator.perlPath = 'mm-perl'
      new_config.settings.perlnavigator.perlcriticProfile = table.concat({ m, 'mm_website/.perlcriticrc' }, '/')
      new_config.settings.perlnavigator.perltidyProfile = table.concat({ m, 'mm_website/.perltidyallrc' }, '/')
    end
  end,
}
