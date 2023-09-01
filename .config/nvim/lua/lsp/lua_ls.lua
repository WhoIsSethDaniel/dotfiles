-- https://github.com/LuaLS/lua-language-server
-- local has_luarc = function()
--   return vim.uv.fs_stat '.luarc.json' or vim.uv.fs_stat '.luarc.jsonc'
-- end

return {
  -- on_init = function(client)
  --   if not has_luarc() then
  --     local config = client.config
  --     config.settings =
  --       vim.tbl_deep_extend('force', config.settings, { Lua = { workspace = { library = { vim.env.VIMRUNTIME } } } })
  --     print(vim.inspect(config.settings))
  --     -- client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  --   end
  -- end,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      hint = { enable = true },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
        -- maxPreload = 4000,
        -- preloadFileSize = 150,
      },
      telemetry = { enable = false },
    },
  },
}
