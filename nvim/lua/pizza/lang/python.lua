return {
   {
      "neovim/nvim-lspconfig",
      opts = {
         servers = {
            ruff_lsp = {},
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
            ruff_lsp = function()
               require("utils").on_lsp_attach(function(client, _)
                  if client.name == "ruff_lsp" then
                     client.server_capabilities.hoverProvider = false
                  end
               end)
            end,
         },
      },
   },
}
