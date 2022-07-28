require('project_nvim').setup {
  detection_methods = { 'lsp', 'pattern' },
  patterns = { 'go.work', '.git', 'go.mod', 'Makefile', 'selene.toml', 'stylua.toml' },
  silent_chdir = true,
  ignore_lsp = { 'null-ls' },
}
