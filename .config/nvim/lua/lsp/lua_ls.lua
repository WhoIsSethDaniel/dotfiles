return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
        -- neededFileStatus = {
        --   ['codestyle-check'] = 'Any',
        -- },
      },
      hint = { enable = true },
      workspace = {
        checkThirdParty = false,
        maxPreload = 4000,
        preloadFileSize = 150,
      },
      telemetry = { enable = false },
    },
  },
}
