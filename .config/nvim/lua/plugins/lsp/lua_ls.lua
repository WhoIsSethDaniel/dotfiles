-- https://github.com/LuaLS/lua-language-server
-- https://luals.github.io/wiki/settings/
return {
  on_init = function(client)
    -- local path = client.workspace_folders and client.workspace_folders[1].name
    -- if path and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
    --   return
    -- end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        -- Depending on the usage, you might want to add additional paths here.
        -- '${3rd}/luv/library',
        -- '${3rd}/busted/library',
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
    })
  end,
  settings = {
    Lua = {
      format = {
        -- use stylua instead
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = 'Auto',
        await = true,
        semicolon = 'Disable',
        paramType = false,
        paramName = 'Disable',
      },
      runtime = {},
      semantic = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        -- maxPreload = 4000,
        -- preloadFileSize = 150,
      },
    },
  },
}
