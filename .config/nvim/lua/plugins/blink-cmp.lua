-- https://github.com/Saghen/blink.cmp
-- most recent stable version
-- https://cmp.saghen.dev/
-- https://cmp.saghen.dev/configuration/reference.html
-- main branch
-- https://main.cmp.saghen.dev/
-- https://main.cmp.saghen.dev/configuration/reference.html
require('blink.cmp').setup {
  -- https://main.cmp.saghen.dev/modes/cmdline.html
  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
  -- https://main.cmp.saghen.dev/configuration/completion.html
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    documentation = {
      auto_show = true,
    },
    ghost_text = {
      enabled = true,
    },
    -- https://main.cmp.saghen.dev/configuration/reference.html#completion-menu
    menu = {
      -- https://main.cmp.saghen.dev/configuration/reference.html#completion-menu-draw
      draw = {
        -- 'label_description' is un-needed b/c colorful-menu deals with that in the 'label'.
        columns = {
          { 'kind_icon' },
          { 'label', gap = 1 },
          { 'source_name' },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
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
          label = {
            text = function(ctx)
              return require('colorful-menu').blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require('colorful-menu').blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },
  -- https://main.cmp.saghen.dev/configuration/fuzzy.html
  fuzzy = {
    implementation = 'lua',
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  -- https://main.cmp.saghen.dev/configuration/keymap.html
  keymap = {
    preset = 'default',
  },
  -- https://main.cmp.saghen.dev/configuration/signature.html
  signature = {
    enabled = true,
    trigger = {
      show_on_accept = true,
    },
    window = {
      show_documentation = true,
    },
  },
  -- https://main.cmp.saghen.dev/configuration/snippets.html
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md
  -- perhaps don't use mini.snippets - see https://github.com/Saghen/blink.cmp/discussions/1766
  -- addendum to discussion linked above: the extra characters seem to be intended. I don't know
  -- why. I don't currently use snippets so simply using the default snippet provider (which is
  -- the vim.snippet.* api) works just fine. Using LuaSnip also doesn't print odd characters by
  -- default so can be a different option.
  -- snippets = {
  --   preset = 'mini_snippets',
  -- },
}
