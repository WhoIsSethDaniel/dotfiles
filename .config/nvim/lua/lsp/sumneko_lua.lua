local lspconfig = require 'lspconfig'

local path = {}
table.insert(path, '?.lua')
table.insert(path, '?/init.lua')

return {
  on_new_config = lspconfig.util.add_hook_after(lspconfig.util.default_config.on_new_config, function(config, root_dir)
    local lib = vim.tbl_deep_extend('force', {}, config.settings.Lua.workspace.library)
    lib[vim.loop.fs_realpath(root_dir) .. '/lua'] = nil
    lib[vim.loop.fs_realpath(root_dir)] = nil
    config.settings.Lua.workspace.library = lib
    return config
  end),
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
        path = path,
      },
      diagnostics = {
        globals = { 'vim' },
        -- neededFileStatus = {
        --   ['codestyle-check'] = 'Any',
        -- },
      },
      -- hint = { enable = true },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        maxPreload = 1000,
        preloadFileSize = 150,
      },
      telemetry = { enable = false },
    },
  },
}
