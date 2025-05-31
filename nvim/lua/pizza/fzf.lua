return {
   {
      "ibhagwan/fzf-lua",
      lazy = true,
      cmd = "FzfLua",
      dependencies = { "devicons" },
      opts = function()
         local actions = require("fzf-lua.actions")
         return {
            actions = {
               files = {
                  ["default"] = actions.file_edit,
                  ["ctrl-h"] = actions.file_split,
                  ["ctrl-v"] = actions.file_vsplit,
                  ["ctrl-q"] = actions.file_sel_to_qf,
                  ["alt-l"] = actions.file_sel_to_ll,
               },
            },
            defaults = {
               fzf_opts = {
                  ["--info"] = "hidden",
               },
            },
            hls = {
               border = "FloatBorder",
               cursorLine = "LineNr",
               help_border = "FloatBorder",
               preview_border = "FloatBorder",
               preview_title = "Identifier",
               scrollborder_f = "LineNr",
               scrollfloat_f = "LineNr",
            },
            winopts = {
               border = "single",
               preview = {
                  border = "single",
                  scrollbar = "border",
               },
            },
         }
      end,
      keys = {
         { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Fuzzy find open buffers" },
         { "<leader>fc", "<cmd>FzfLua git_branches<cr>", desc = "Fuzzy find and check out a git branch" },
         { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Fuzzy find keywords in Neovim help" },
         { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Fuzzy find keymaps" },
         { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Fuzzy find recently opened files" },
         { "<leader>fr", "<cmd>FzfLua registers<cr>", desc = "Fuzzy find register contents" },
         { "<leader>t", "<cmd>FzfLua files<cr>", desc = "Fuzzy find files" },
         { "<leader>gc", "<cmd>FzfLua grep_cword<cr>", desc = "Live grep for the current word" },
         { "<leader>gg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep through the current project" },
         { "<leader>gp", "<cmd>FzfLua grep_last<cr>", desc = "Live grep for the previous pattern" },
         {
            "<leader>fd",
            function()
               require("fzf-lua").files({
                  cmd = [[git diff --name-only --diff-filter=d "$(git merge-base master HEAD).."]],
               })
            end,
            desc = "Fuzzy find files changed in this branch off master",
         },
         {
            "<C-r>",
            "<cmd>FzfLua registers<cr>",
            mode = "i",
            desc = "Fuzzy find register contents",
         },
      },
   },
}
