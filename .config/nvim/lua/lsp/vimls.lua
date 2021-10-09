-- https://github.com/iamcco/vim-language-server
return {
  settings = {
    vimls = {
      iskeyword = '@,48-57,_,192-255,-#',
      vimruntime = os.getenv 'VIMRUNTIME',
      runtimepath = vim.api.nvim_get_option 'rtp',
      diagnostic = { enable = true },
      indexes = {
        runtimepath = true,
        gap = 100,
        count = 3,
        projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
      },
      suggest = { fromVimruntime = true, fromRuntimepath = true },
    },
  },
}
