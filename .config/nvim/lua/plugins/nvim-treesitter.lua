--  https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--  https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
--  https://www.reddit.com/r/neovim/comments/1pndf9e/my_new_nvimtreesitter_configuration_for_the_main/
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd.TSUpdate()
  end,
})

local auto_install = {
  'comment',
  'diff',
  'luadoc',
  'pod',
  'regex',
  'sql',
}

local ts = require 'nvim-treesitter'

ts.install(auto_install)

local ignore_filetypes = {}

-- Auto-install parsers and enable highlighting on FileType
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
  desc = 'Enable treesitter highlighting and indentation',
  callback = function(event)
    if vim.tbl_contains(ignore_filetypes, event.match) then
      return
    end

    local lang = vim.treesitter.language.get_lang(event.match) or event.match
    local buf = event.buf

    -- Install missing parsers (no-op if already installed)
    ts.install(lang):await(function()
      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(buf, lang)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end)
  end,
})
