local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("PythonOptions", { clear = true })
autocmd("FileType", {
  group = "PythonOptions",
  pattern ={ "python" },
  command = [[
    setlocal shiftwidth=4
    setlocal tabstop=4
    setlocal expandtab
    setlocal textwidth=120
    setlocal colorcolumn=+1
  ]],
})
