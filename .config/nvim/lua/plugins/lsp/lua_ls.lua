-- https://github.com/LuaLS/lua-language-server
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
return {
  settings = {
    Lua = {
      format = {
        -- use stylua instead
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      hint = {
        enable = true,
        arrayIndex = 'Auto',
        await = true,
        semicolon = 'Disable',
        paramType = false,
        paramName = 'Disable',
      },
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
