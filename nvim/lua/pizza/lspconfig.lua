return {
   {
      "neovim/nvim-lspconfig",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      dependencies = { "mason.nvim", "williamboman/mason-lspconfig.nvim" },
      ---@class PluginLspOpts
      opts = {
         diagnostics = {
            underline = true,
            update_in_insert = false,
         },
         servers = {
            gopls = { mason = false },
         },
      },
      ---@param opts PluginLspOpts
      config = function(_, opts)
         require("lspconfig.ui.windows").default_options.border = "single"
         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "single",
         })
         vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

         local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
         )

         local on_attach = function(_, bufnr)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to symbol definition" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references to symbol" })
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
            vim.keymap.set("n", "<leader>ca", function()
               vim.lsp.buf.code_action({ apply = true })
            end, { buffer = bufnr, desc = "Apply Code Action" })
            vim.keymap.set(
               "i",
               "<C-k>",
               vim.lsp.buf.signature_help,
               { buffer = bufnr, desc = "Show function signature inline" }
            )
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation under cursor" })
            vim.keymap.set("n", "<leader>fs", function()
               require("fzf-lua").lsp_document_symbols()
            end, { buffer = bufnr, desc = "Fuzzy find symbols in the current document" })
         end

         local servers = opts.servers

         require("mason").setup()

         local setup = function(server)
            local server_opts = vim.tbl_deep_extend("force", {
               capabilities = vim.deepcopy(capabilities),
               on_attach = on_attach,
            }, servers[server] or {})

            if opts.setup[server] then
               if opts.setup[server](server, server_opts) then
                  return
               end
            end

            require("lspconfig")[server].setup(server_opts)
         end

         local all_mason_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

         local ensure_installed = {} ---@type string[]
         for server, server_opts in pairs(servers) do
            if server_opts then
               server_opts = server_opts == true and {} or server_opts
               -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
               if server_opts.mason == false or not vim.tbl_contains(all_mason_servers, server) then
                  setup(server)
               else
                  ensure_installed[#ensure_installed + 1] = server
               end
            end
         end

         require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = ensure_installed,
            handlers = { setup },
         })
      end,
   },
}
