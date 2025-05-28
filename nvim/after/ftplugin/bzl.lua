-- setup bazel/starlark lsp
if vim.fn.executable('bzl') == 1 then
   local cmd = { "git", "rev-parse", "--show-toplevel" }
   local output = vim.fn.systemlist(cmd)
   vim.lsp.start({
      name = 'Bazel/Starlark Language Server',
      cmd = { 'bzl', 'lsp', 'serve', '--base_dir', output[1] },
   })
end
