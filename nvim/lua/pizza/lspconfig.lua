local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.lsp.config("*", {
   capabilities = vim.lsp.protocol.make_client_capabilities(),
})

autocmd("LspAttach", {
   group = augroup("pizza.lsp", {}),
   callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to symbol definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Find references to symbol" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", function()
         vim.lsp.buf.code_action({ apply = true })
      end, { buffer = args.buf, desc = "Apply Code Action" })
      vim.keymap.set("n", "<leader>fs", function()
         require("fzf-lua").lsp_document_symbols()
      end, { buffer = args.buf, desc = "Fuzzy find symbols in the current document" })

      if client:supports_method("textDocument/hover", args.buf) then
         vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "single" })
         end, { buffer = args.buf, desc = "Hover documentation under cursor" })
      end

      if client:supports_method("textDocument/signatureHelp", args.buf) then
         vim.keymap.set("i", "<C-k>", function()
            vim.lsp.buf.signature_help({ border = "single" })
         end, { buffer = args.buf, desc = "Show function signature inline" })
      end
   end,
})

return {
   {
      "neovim/nvim-lspconfig",
      keys = {
         { "<leader>ns", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      },
   },
   {
      "mason-org/mason.nvim",
      keys = {
         { "<leader>nm", "<cmd>Mason<cr>", desc = "Mason" },
      },
      opts = {
         pip = {
            upgrade_pip = true,
         },
         ui = {
            border = "single",
         },
      },
   },
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
         "neovim/nvim-lspconfig",
         "mason-org/mason.nvim",
         "j-hui/fidget.nvim",
      },
      opts = {
         ensure_installed = {
            "basedpyright",
            "bashls",
            "lua_ls",
         },
      },
   },
}
