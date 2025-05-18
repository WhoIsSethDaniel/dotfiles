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
    accept = {
      auto_brackets = {
        enabled = true,
        kind_resolution = {
          -- block 'go' to force semantic resolution;
          -- see https://github.com/Saghen/blink.cmp/discussions/1766
          blocked_filetypes = { 'go' },
        },
      },
    },
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
          -- https://github.com/Saghen/blink.cmp/issues/1317#issuecomment-2762258454
          -- https://github.com/Saghen/blink.cmp/issues/1610
          label_description = {
            width = {
              max = 80,
            },
            text = function(ctx)
              return ctx.label_description ~= '' and ctx.label_description or ctx.item.detail
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
    trigger = {
      show_on_accept = true,
      show_on_insert = true,
    },
    window = {
      show_documentation = true,
    },
  },
  -- https://cmp.saghen.dev/configuration/snippets.html
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md
  snippets = {
    preset = 'mini_snippets',
  },
}
