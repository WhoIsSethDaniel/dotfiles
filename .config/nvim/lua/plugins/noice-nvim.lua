require('noice').setup {
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
  },
  messages = {
    enabled = true,
    view = 'mini',
    view_error = 'mini',
    view_warn = 'mini',
    view_history = 'split',
    view_search = 'virtualtext',
  },
  notify = {
    enabled = true,
    view = 'mini',
  },
  views = {
    mini = {
      timeout = 4000,
    },
  },
  lsp = {
    progress = {
      enabled = true,
      format = 'lsp_progress',
      format_done = 'lsp_progress_done',
      view = 'mini',
    },
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
      auto_open = { enabled = false },
    },
    message = {
      enabled = true,
      view = 'mini',
      opts = {},
    },
  },
}
