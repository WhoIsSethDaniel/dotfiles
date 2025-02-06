local autocmds = {
  doc_settings_and_win = {
    {
      FileType = {
        pattern = { 'help', 'man' },
        command = 'wincmd L',
      },
    },
    {
      FileType = {
        pattern = { 'help', 'man' },
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = 'no'
          -- setting this to 'wipe' breaks jumplist in help
          vim.opt_local.bufhidden = 'delete'
        end,
      },
    },
  },
  highlight_yank = {
    {
      TextYankPost = {
        callback = function()
          vim.highlight.on_yank {
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
          vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { silent = true, noremap = true })
          -- all these options are now off by default as of 0.11; see :h terminal-config
          -- vim.opt_local.signcolumn = 'no'
          -- vim.opt_local.number = false
          -- vim.opt_local.relativenumber = false
          -- vim.api.nvim_command 'startinsert'
        end,
      },
    },
  },
  vim_on_start = {
    {
      VimEnter = {
        callback = function()
          vim.defer_fn(function()
            vim.cmd [[ TSUpdate ]]
            vim.cmd [[ helptags ALL ]]
          end, 1000)
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
