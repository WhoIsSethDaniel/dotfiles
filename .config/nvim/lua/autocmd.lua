-- find all third-party plugins and rebuild the help tags
local rebuild_help = function()
  vim.notify 'rebuild all third-party plugin help tags'
  for _, rtdir in pairs(vim.opt.runtimepath:get()) do
    local docdir = vim.fn.glob(vim.fn.expand(vim.fn.fnameescape(rtdir .. '/doc')))
    local tagsfile = vim.fn.glob(docdir .. '/tags')
    if
      (#tagsfile > 0 and vim.fn.filewritable(tagsfile) == 1) or (#tagsfile == 0 and vim.fn.filewritable(docdir) == 2)
    then
      vim.api.nvim_command('helptags' .. docdir)
    end
  end
end

local autocmds = {
  -- fix_telescope_insert = {
  --   {
  --     -- https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1510001730
  --     -- workaround for: https://github.com/nvim-telescope/telescope.nvim/issues/2501
  --     WinLeave = {
  --       callback = function()
  --         if vim.bo.ft == 'TelescopePrompt' and vim.fn.mode() == 'i' then
  --           vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'i', false)
  --         end
  --       end,
  --     },
  --   },
  -- },
  -- spelling = {
  --   {
  --     FileType = {
  --       pattern = { 'go', 'lua', 'perl', 'sh' },
  --       callback = function()
  --         -- turn on spellsitter support
  --         vim.opt_local.spell = true
  --         vim.opt_local.spelloptions = 'noplainbuffer'
  --       end,
  --     },
  --   },
  -- },
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
          vim.opt_local.signcolumn = 'no'
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
            rebuild_help()
            vim.cmd [[ TSUpdate ]]
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
  use_modeline_for_help = {
    {
      -- locally turn on modelines for anything
      -- that looks like a help file. This will
      -- allow the modeline to set the correct
      -- filetype for plugin help files.
      BufReadPost = {
        pattern = { '*/doc/*.txt' },
        callback = function()
          vim.opt_local.modeline = true
          vim.opt_local.modelines = 5
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
