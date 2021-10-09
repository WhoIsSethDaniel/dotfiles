require('toggle_lsp_diagnostics').init()

-- nnoremap <leader>tls <Plug>(toggle-lsp-diag-signs)
-- nnoremap <leader>tlp <Plug>(toggle-lsp-diag-update_in_insert)
-- nnoremap <leader>tldo <Plug>(toggle-lsp-diag-off)
-- nnoremap <leader>tldf <Plug>(toggle-lsp-diag-on)

-- vim.api.nvim_set_keymap('n', '<leader>tlds', '<Plug>(toggle-lsp-diag-scope)', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tldv', '<Plug>(toggle-lsp-diag-vtext)', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tldd', '<Plug>(toggle-lsp-diag-default)', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tud', '<Plug>(toggle-lsp-diag-underline)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<Plug>(toggle-lsp-diag)', { silent = true })
