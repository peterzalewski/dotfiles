return {
   {
      "neovim/nvim-lspconfig",
      opts = {
         servers = {
            ruff = {},
            pyright = {
               settings = {
                  python = {
                     analysis = {
                        diagnosticMode = "openFilesOnly",
                     },
                  },
               },
            },
         },
         setup = {
            ruff = function()
               require("utils").on_lsp_attach(function(client, _)
                  if client.name == "ruff" then
                     client.server_capabilities.hoverProvider = false
                  end
               end)
            end,
         },
      },
   },
}
