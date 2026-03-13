require('lsp-cd').setup {
  ignore = { 'dprint' },
  notify = {
    on_nil_root_dir = true,
    on_dir_change = true,
  },
}
