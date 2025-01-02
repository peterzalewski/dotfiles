local M = {}

function M.on_lsp_attach(on_attach)
   vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
         local client = vim.lsp.get_buffers_by_client_id(args.data.client_id)
         local buffer = args.buf
         on_attach(client, buffer)
      end,
   })
end

return M
