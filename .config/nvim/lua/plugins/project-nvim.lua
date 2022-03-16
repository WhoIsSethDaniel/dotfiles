require('project_nvim').setup {
  patterns = { 'go.work', '.git', 'go.mod', 'Makefile' },
  silent_chdir = true,
  ignore_lsp = { 'null-ls' },
}
