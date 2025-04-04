-- https://github.com/Saghen/blink.cmp
-- https://cmp.saghen.dev/
-- https://cmp.saghen.dev/configuration/reference.html
require('blink.cmp').setup {
  -- https://cmp.saghen.dev/configuration/keymap.html
  keymap = {
    preset = 'default',
  },
  -- https://cmp.saghen.dev/configuration/fuzzy.html
  fuzzy = {
    implementation = 'lua',
  },
  -- https://cmp.saghen.dev/configuration/signature.html
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
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
  },
  -- https://cmp.saghen.dev/modes/cmdline.html
  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
}
