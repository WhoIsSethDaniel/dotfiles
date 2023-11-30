-- https://github.com/tekumara/typos-vscode
return {
  filetypes = { 'go', 'lua', 'markdown', 'sql', 'vim', 'yaml', 'gohtmltmpl', 'json', 'sh', 'toml' },
  settings = {
    typos = {
      -- unclear if this is being used
      path = vim.env.MASON .. '/bin/typos',
      diagnosticSeverity = 'Warning',
    },
  },
}
