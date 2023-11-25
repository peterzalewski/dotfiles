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
	vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, { buffer = bufnr, desc = "Format current file" })
	vim.keymap.set("n", "<leader>c", function()
		require("fzf-lua").lsp_document_symbols()
	end, { desc = "Fuzzy find symbols in the current document" })
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
