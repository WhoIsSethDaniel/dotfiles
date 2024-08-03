-- nvim 0.10 doesn't include a commentstring for sql, but this was fixed in 0.11
if vim.fn.has 'nvim-0.10.0' == 1 and vim.fn.has 'nvim-0.11.0' == 0 then
  vim.opt_local.commentstring = '-- %s'
end
