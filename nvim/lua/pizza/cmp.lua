local border = {
   { "╭", "CmpBorder" },
   { "─", "CmpBorder" },
   { "╮", "CmpBorder" },
   { "│", "CmpBorder" },
   { "╯", "CmpBorder" },
   { "─", "CmpBorder" },
   { "╰", "CmpBorder" },
   { "│", "CmpBorder" },
}

return {
   {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
         "devicons",
         "luasnip",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-emoji",
         "saadparwaiz1/cmp_luasnip",
         "onsails/lspkind.nvim",
      },
      config = function()
         local cmp = require("cmp")
         cmp.setup({
            completion = {
               completeopt = "menu,menuone,noinsert",
            },
            enabled = function()
               -- disable completion in comments
               local context = require("cmp.config.context")
               -- keep command mode completion enabled when cursor is in a comment
               if vim.api.nvim_get_mode().mode == "c" then
                  return true
               else
                  return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
               end
            end,
            formatting = {
               expandable_indicator = true,
               fields = { "kind", "abbr", "menu" },
               format = function(entry, vim_item)
                  if vim.tbl_contains({ "path" }, entry.source.name) then
                     local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                     if icon then
                        vim_item.kind = icon
                        vim_item.kind_hl_group = hl_group
                     end
                     return vim_item
                  end
                  return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
               end,
            },
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            view = {
               entries = {
                  name = "custom",
                  selection_order = "top_down",
                  follow_cursor = true,
               },
            },
            mapping = cmp.mapping.preset.insert({
               ["<C-space>"] = function(fallback)
                  if cmp.visible() then
                     cmp.close()
                  else
                     fallback()
                  end
               end,
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<Tab>"] = function(fallback)
                  local entries = cmp.get_entries()
                  if cmp.visible() then
                     if #entries == 1 then
                        cmp.confirm({ select = true })
                     else
                        cmp.select_next_item()
                     end
                  else
                     fallback()
                  end
               end,
               ["<S-Tab>"] = function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  else
                     fallback()
                  end
               end,
            }),
            sources = cmp.config.sources({ name = "luasnip", priority = 50 }, { name = "lazydev" }, {
               { name = "nvim_lsp", priority = 50 },
               { name = "path", priority = 40 },
               { name = "nvim_lua", priority = 40 },
            }, {
               { name = "buffer", priority = 50, keyword_length = 3 },
               { name = "emoji", insert = true, priority = 20 },
            }),
            window = {
               documentation = {
                  border = border,
               },
               completion = {
                  border = border,
               },
            },
         })
         -- Tab when there's only one match left also completes
         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
               { name = "path" },
            }, {
               { name = "cmdline" },
            }),
         })

         cmp.setup.filetype("procfile", {
            sources = cmp.config.sources({
               { name = "path" },
            }),
         })

         cmp.setup.filetype("json", {
            sources = cmp.config.sources({
               { name = "path" },
            }),
         })
      end,
   },
}
