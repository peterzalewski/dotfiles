---@param opts PluginLspOpts
local function lspconfig(_, opts)
   require("lspconfig.ui.windows").default_options.border = "single"
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

   local on_attach = function(_, bufnr)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to symbol definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references to symbol" })
      vim.keymap.set("n", "gpr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
      vim.keymap.set(
         "i",
         "<C-k>",
         vim.lsp.buf.signature_help,
         { buffer = bufnr, desc = "Show function signature inline" }
      )
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation under cursor" })
      vim.keymap.set("n", "<leader>c", function()
         require("fzf-lua").lsp_document_symbols()
      end, { desc = "Fuzzy find symbols in the current document" })
   end

   local servers = opts.servers
   local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
         capabilities = vim.deepcopy(capabilities),
         on_attach = on_attach,
      }, servers[server] or {})

      if opts.setup[server] then
         if opts.setup[server](server, server_opts) then
            return
         end
      elseif opts.setup["*"] then
         if opts.setup["*"](server, server_opts) then
            return
         end
      end
      require("lspconfig")[server].setup(server_opts)
   end

   -- get all the servers that are available through mason-lspconfig
   local have_mason, mlsp = pcall(require, "mason-lspconfig")
   local all_mslp_servers = {}
   if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
   end

   local ensure_installed = {} ---@type string[]
   for server, server_opts in pairs(servers) do
      if server_opts then
         server_opts = server_opts == true and {} or server_opts
         -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
         if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
         else
            ensure_installed[#ensure_installed + 1] = server
         end
      end
   end

   if have_mason then
      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
   end
end

return {
   {
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
      lazy = true,
      cmd = "Mason",
      name = "mason",
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
      "neovim/nvim-lspconfig",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      dependencies = { { "folke/neodev.nvim", opts = {} }, "mason", "fidget" },
      ---@class PluginLspOpts
      opts = {
         diagnostics = {
            underline = true,
         },
         servers = {
            gopls = { mason = false },
            lua_ls = {
               Lua = {
                  workspace = {
                     checkThirdParty = false,
                     diagnostics = {
                        globals = { "vim" },
                     },
                     library = { "${3rd}/luv/library" },
                     semantic = {
                        enable = false,
                     },
                  },
                  format = {
                     defaultConfig = {
                        indent_style = "space",
                        indent_size = "3",
                        continuation_indent_size = "3",
                     },
                  },
               },
               pylsp = {
                  pylsp = {
                     plugins = {
                        mccabe = {
                           enabled = false,
                        },
                        pycodestyle = {
                           enabled = false,
                        },
                        pyflakes = {
                           enabled = false,
                        },
                        pylint = {
                           enabled = false,
                        },
                        ruff = {
                           enabled = true,
                        },
                     },
                  },
               },
            },
         },
        setup = { },
      },
      config = lspconfig,
   },
   {
      "stevearc/conform.nvim",
      dependencies = { "neovim/nvim-lspconfig" },
      opts = {
         formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
         },
      },
      keys = {
         {
            "<leader>F",
            function()
               require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format buffer",
         },
      },
   },
   {
      "j-hui/fidget.nvim",
      name = "fidget",
      lazy = true,
      opts = {
         progress = {
            ignore_done_already = true,
         },
         notification = {
            window = {
               winblend = 0,
            },
         },
      },
   },
}
