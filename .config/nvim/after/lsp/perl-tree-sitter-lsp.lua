-- https://github.com/tree-sitter-perl/perl-tree-sitter-lsp#neovim-011
return {
  cmd = { 'perl-tree-sitter-lsp' },
  filetypes = { 'perl' },
  root_markers = { 'cpanfile', 'Makefile.PL', 'Build.PL', '.git' },
}
