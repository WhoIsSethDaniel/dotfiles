vim.g.netrw_nogx = 1
vim.g.openbrowser_browser_commands = {
  { name = 'local-open', args = { '{browser}', '{uri}' } },
  { name = 'xdg-open', args = { '{browser}', '{uri}' } },
  { name = 'x-www-browser', args = { '{browser}', '{uri}' } },
  { name = 'firefox', args = { '{browser}', '{uri}' } },
  { name = 'w3m', args = { '{browser}', '{uri}' } },
}

vim.api.nvim_set_keymap('n', 'gx', '<plug>(openbrowser-smart-search)', {})
vim.api.nvim_set_keymap('v', 'gx', '<plug>(openbrowser-smart-search)', {})
