require('lsp-cd').setup {
  notify = {
    on_nil_root_dir = true,
    on_dir_change = true,
  },
}
