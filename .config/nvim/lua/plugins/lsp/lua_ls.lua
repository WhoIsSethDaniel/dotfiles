-- https://github.com/LuaLS/lua-language-server
return {
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
