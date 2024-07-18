require('project_nvim').setup {
  detection_methods = { 'lsp', 'pattern' },
  patterns = { '.git', 'go.work', 'go.mod', 'selene.toml', 'stylua.toml' },
  silent_chdir = true,
  ignore_lsp = {},
  scope_chdir = 'global',
}
