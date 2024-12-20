-- https://github.com/Saghen/blink.cmp
require('blink.cmp').setup {
  enabled = function()
    return true
  end,
  -- 'default' for mappings similar to built-in completion
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  -- see the "default configuration" section below for full documentation on how to define
  -- your own keymap.
  keymap = { preset = 'default' },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  -- default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, via `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    -- optionally disable cmdline completions
    -- cmdline = {},
  },

  -- experimental signature help support
  signature = { enabled = true },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },

  fuzzy = {
    prebuilt_binaries = {
      force_version = 'v0.7.6',
    },
  },
}
