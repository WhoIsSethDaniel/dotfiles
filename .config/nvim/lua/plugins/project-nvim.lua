require('project_nvim').setup {
  detection_methods = { 'lsp', 'pattern' },
  patterns = { 'go.work', '.git', 'go.mod', 'selene.toml', 'stylua.toml' },
  silent_chdir = true,
  ignore_lsp = {},
  scope_chdir = 'global',
}
