-- https://github.com/EffortlessMetrics/perl-lsp/blob/master/docs/EDITORS/NEOVIM_SETUP.md
--
return {
  cmd = { 'perllsp', '--stdio' },
  filetypes = { 'perl' },
  root_markers = { 'cpanfile', 'Makefile.PL', 'Build.PL', '.git' },
  init_options = {
    perl = {
      workspace = {
        includePaths = { 'lib', '.', 'local/lib/perl5' },
        useSystemInc = false,
        resolutionTimeout = 50,
      },
    },
  },
}
