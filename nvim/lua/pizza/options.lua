local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

if vim.env.NVIM_PYTHON and vim.uv.fs_stat(vim.env.NVIM_PYTHON) then
   vim.g.python3_host_prog = vim.env.NVIM_PYTHON
end
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
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.formatoptions = "qcjt"
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
vim.opt.wildignore:append({ ".git", "node_modules" })
vim.opt.wildmenu = true
vim.opt.writebackup = false
vim.opt.signcolumn = "yes"
vim.opt.spelllang = { "en" }
-- vim.opt.spell = true
vim.opt.spelloptions = "camel"

vim.diagnostic.config({
   float = { border = "rounded" },
   signs = {
      text = {
         [vim.diagnostic.severity.INFO] = "",
         [vim.diagnostic.severity.WARN] = "⚠",
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.HINT] = "",
      },
      numhl = {
         [vim.diagnostic.severity.INFO] = "DiagnosticInformation",
         [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
         [vim.diagnostic.severity.ERROR] = "DiagnosticError",
         [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      },
   },
   underline = true,
   virtual_text = true,
})

autocmd("BufWinEnter", {
   group = augroup("pizza: Detect filetype", { clear = true }),
   callback = function(args)
      if vim.bo[args.buf].filetype == "" and vim.bo[args.buf].buftype == "" and vim.api.nvim_buf_get_name(args.buf) ~= "" then
         vim.cmd.filetype("detect")
      end
   end,
})

-- vim.schedule defers until after snacks finishes setting up the window,
-- which otherwise overwrites wo options set via snacks_win_opts.
autocmd("FileType", {
   group = augroup("pizza: Style snacks_terminal", { clear = true }),
   pattern = { "snacks_terminal" },
   callback = function()
      vim.schedule(function()
         vim.wo.statusline = " "
         vim.wo.winhighlight = "Normal:ClaudeTermNormal,NormalNC:ClaudeTermNormalNC,StatusLine:ClaudeTermStatusLine,StatusLineNC:ClaudeTermStatusLineNC"
      end)
   end,
})

autocmd("FileType", {
   group = augroup("pizza: Disable spellcheck", { clear = true }),
   pattern = {
      "qf",
   },
   command = "setlocal nospell",
})

return {}
