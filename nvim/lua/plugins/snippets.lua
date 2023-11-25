local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.add_snippets("all", {
	s("nvimmap", {
		t("vim.keymap.set({"),
		i(1, "modes"),
		t("}, '"),
		i(2, "lhs"),
		t("', '"),
		i(3, "rhs"),
		t("', { silent = true, desc = '"),
		i(4, "desc"),
		t("' })"),
	}),
})
