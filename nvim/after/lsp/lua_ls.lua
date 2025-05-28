---@class vim.lsp.ClientConfig
return {
   settings = {
      Lua = {
         diagnostics = {
            globals = {
               "vim",
               "require",
            },
         },
         hint = {
            enable = true,
         },
         runtime = {
            version = "LuaJIT",
         },
         telemetry = {
            enable = false,
         },
         workspace = {
            checkThirdParty = false,
         },
      },
   },
}
