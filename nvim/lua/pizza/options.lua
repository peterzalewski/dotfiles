vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = { "eol", "indent", "start" }
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = "unnamed"
vim.opt.expandtab = true
vim.opt.fileformats = { "unix", "mac", "dos" }
vim.opt.fillchars = { eob = " ", vert = " ", horiz = " " }
vim.opt.foldlevelstart = 20
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.formatoptions = "qcj"
vim.opt.gdefault = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.laststatus = 2
vim.opt.modelines = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.ttyfast = true
vim.opt.wildignore:append({ ".git", "node_modules" })
vim.opt.wildmenu = true
vim.opt.writebackup = false
vim.wo.signcolumn = "yes"

vim.diagnostic.config({
	float = { border = "rounded" },
	signs = true,
	underline = false,
	virtual_text = false,
})

return {}
