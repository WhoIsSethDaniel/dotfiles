-- this must be here since filetype detection now
-- happens prior to init.lua being sourced
if vim.fn.has 'nvim-0.7' == 1 then
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
end
