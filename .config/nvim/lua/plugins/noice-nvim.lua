-- https://github.com/folke/noice.nvim
-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
require('noice').setup {
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    -- view = 'cmdline',
  },
  messages = {
    enabled = false,
    view = 'mini',
    view_error = 'mini',
    view_warn = 'mini',
    view_history = 'messages',
    view_search = 'virtualtext',
  },
  popupmenu = {
    enabled = false,
  },
  notify = {
    enabled = false,
    view = 'mini',
  },
  views = {
    mini = {
      timeout = 4000,
    },
    cmdline_popup = {
      -- position = {
      --   row = -3,
      -- },
      border = {
        style = 'none',
        padding = { 2, 3 },
      },
      filter_options = {},
      win_options = {
        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      },
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
      enabled = true,
    },
    signature = {
      enabled = true,
    },
    message = {
      enabled = true,
      view = 'mini',
      opts = {},
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
}
