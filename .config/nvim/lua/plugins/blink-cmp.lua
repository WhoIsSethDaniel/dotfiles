-- https://github.com/Saghen/blink.cmp
-- https://cmp.saghen.dev/
-- https://cmp.saghen.dev/configuration/reference.html
require('blink.cmp').setup {
  -- https://cmp.saghen.dev/modes/cmdline.html
  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
  -- https://cmp.saghen.dev/configuration/completion.html
  completion = {
    documentation = {
      auto_show = true,
    },
    ghost_text = {
      enabled = true,
    },
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
        },
      },
    },
  },
  -- https://cmp.saghen.dev/configuration/fuzzy.html
  fuzzy = {
    implementation = 'lua',
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  -- https://cmp.saghen.dev/configuration/keymap.html
  keymap = {
    preset = 'default',
  },
  -- https://cmp.saghen.dev/configuration/signature.html
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
  },
}
