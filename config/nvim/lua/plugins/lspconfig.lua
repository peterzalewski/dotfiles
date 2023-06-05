require("neodev").setup({})
require("rust-tools").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local server_settings = {
	gopls = {},
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
					enabled = true,
				},
			},
		},
	},
}

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, opts)
end

require("mason").setup({
	pip = {
		upgrade_pip = true,
	},
})
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(server_settings),
})
mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = server_settings[server_name],
		})
	end,
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
