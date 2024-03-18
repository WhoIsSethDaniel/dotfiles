-- https://github.com/chrishrb/gx.nvim

-- by default neovim sets 'gx' to vim.ui.open()
vim.keymap.set({ 'n', 'x' }, 'gx', '<cmd>Browse<cr>')
require('gx').setup {
  open_browser_app = 'xdg-open', -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
  -- open_browser_args = { '--background' }, -- specify any arguments, such as --background for macOS' "open".
  handlers = {
    plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
    github = true, -- open github issues
    brewfile = false, -- open Homebrew formulas and casks
    package_json = true, -- open dependencies from package.json
    search = true, -- search the web/selection on the web if nothing else is found
    -- jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
    --   handle = function(mode, line, _)
    --     local ticket = require('gx.helper').find(line, mode, '(%u+-%d+)')
    --     if ticket and #ticket < 20 then
    --       return 'http://jira.company.com/browse/' .. ticket
    --     end
    --   end,
    -- },
    -- rust = { -- custom handler to open rust's cargo packages
    --   filetype = { 'toml' }, -- you can also set the required filetype for this handler
    --   filename = 'Cargo.toml', -- or the necessary filename
    --   handle = function(mode, line, _)
    --     local crate = require('gx.helper').find(line, mode, '(%w+)%s-=%s')
    --
    --     if crate then
    --       return 'https://crates.io/crates/' .. crate
    --     end
    --   end,
    -- },
  },
  handler_options = {
    search_engine = 'google', -- you can select between google, bing, duckduckgo, and ecosia
    -- search_engine = 'https://search.brave.com/search?q=', -- or you can pass in a custom search engine
  },
}
