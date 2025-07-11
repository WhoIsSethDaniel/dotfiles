local autocmds = {
  create_missing_dirs = {
    {
      BufWritePre = {
        callback = function(opts)
          local dir = vim.fs.dirname(vim.fs.normalize(opts.file))
          if dir:find '://' then
            return
          end
          if not vim.uv.fs_stat(dir) then
            vim.fn.mkdir(dir, 'p')
          end
        end,
      },
    },
  },
  doc_settings_and_win = {
    {
      FileType = {
        pattern = { 'help', 'man' },
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = 'no'
          -- setting this to 'wipe' breaks jumplist in help
          vim.opt_local.bufhidden = 'delete'
          vim.cmd.wincmd 'L'
        end,
      },
    },
  },
  highlight_yank = {
    {
      TextYankPost = {
        callback = function()
          vim.hl.on_yank {
            higroup = 'IncSearch',
            timeout = 500,
            on_visual = true,
          }
        end,
      },
    },
  },
  terminal_settings = {
    {
      TermOpen = {
        callback = function()
          -- allow window movements
          vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { silent = true, noremap = true })
        end,
      },
    },
  },
  vim_on_start = {
    {
      VimEnter = {
        callback = function()
          vim.cmd.helptags { 'ALL' }
        end,
      },
    },
  },
  ephemeral_bufs = {
    {
      FileType = {
        pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
        callback = function()
          vim.opt_local.bufhidden = 'wipe'
        end,
      },
    },
  },
}

-- setup all autocmds
do
  for group, grpdef in pairs(autocmds) do
    vim.api.nvim_create_augroup(group, { clear = true })
    for _, events in ipairs(grpdef) do
      -- this never has more than one event
      for event, eventdef in pairs(events) do
        vim.api.nvim_create_autocmd(event, eventdef)
      end
    end
  end
end
