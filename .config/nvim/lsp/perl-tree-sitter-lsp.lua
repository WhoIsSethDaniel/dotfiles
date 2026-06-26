-- https://github.com/tree-sitter-perl/perl-tree-sitter-lsp#neovim-011

-- https://github.com/tree-sitter-perl/perl-lsp#semantic-token-colors-neovim
vim.api.nvim_set_hl(0, '@lsp.type.macro.perl', { link = 'Keyword' }) -- has, with, extends
vim.api.nvim_set_hl(0, '@lsp.type.property.perl', { link = 'Identifier' }) -- hash keys
vim.api.nvim_set_hl(0, '@lsp.type.namespace.perl', { link = 'Type' }) -- Foo::Bar
vim.api.nvim_set_hl(0, '@lsp.type.parameter.perl', { link = 'Special' }) -- sub params
vim.api.nvim_set_hl(0, '@lsp.type.keyword.perl', { link = 'Constant' }) -- $self/$class
vim.api.nvim_set_hl(0, '@lsp.mod.scalar.perl', { fg = '#61afef' }) -- $ blue
vim.api.nvim_set_hl(0, '@lsp.mod.array.perl', { fg = '#c678dd' }) -- @ purple
vim.api.nvim_set_hl(0, '@lsp.mod.hash.perl', { fg = '#e5c07b' }) -- % gold
vim.api.nvim_set_hl(0, '@lsp.mod.modification.perl', { fg = '#e06c75' }) -- writes in red
vim.api.nvim_set_hl(0, '@lsp.mod.declaration.perl', { bold = true })
vim.api.nvim_set_hl(0, '@lsp.mod.readonly.perl', { italic = true })
vim.api.nvim_set_hl(0, '@lsp.mod.defaultLibrary.perl', { italic = true }) -- imported functions

return {
  cmd = { 'perl-tree-sitter-lsp' },
  filetypes = { 'perl' },
  root_markers = { 'cpanfile', 'Makefile.PL', 'Build.PL', '.git' },
}
