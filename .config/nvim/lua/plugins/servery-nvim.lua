require('servery').setup {
  dirs = { '~' },
  session_dir = vim.fs.joinpath(vim.fn.stdpath 'cache', 'servery.nvim'),
  ui = {
    provider = 'snacks',
  },
}
