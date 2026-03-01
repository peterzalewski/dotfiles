local HarpoonDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()

function HarpoonDecorator:new()
   self.enabled = true
   self.highlight_range = "name"
   self.icon_placement = "right_align"
end

-- Build a set of absolute paths and a set of ancestor directories from the harpoon list.
-- Results are cached per render cycle (new() is called each cycle).
function HarpoonDecorator:_build_cache()
   if self._cache then
      return
   end

   self._cache = { files = {}, ancestors = {} }

   local ok, harpoon = pcall(require, "harpoon")
   if not ok then
      return
   end

   local list = harpoon:list()
   local cwd = vim.uv.cwd() or ""

   for i, item in ipairs(list.items) do
      local abs = item.value
      if not vim.startswith(abs, "/") then
         abs = cwd .. "/" .. abs
      end
      self._cache.files[abs] = i

      -- Record every ancestor directory
      local dir = vim.fn.fnamemodify(abs, ":h")
      while dir and dir ~= "/" and dir ~= "." do
         if self._cache.ancestors[dir] then
            break -- already walked this path from a previous item
         end
         self._cache.ancestors[dir] = true
         dir = vim.fn.fnamemodify(dir, ":h")
      end
   end
end

function HarpoonDecorator:icons(node)
   self:_build_cache()

   if node.type == "file" then
      local index = self._cache.files[node.absolute_path]
      if index then
         return { { str = " " .. index, hl = { "NvimTreeHarpoonIcon" } } }
      end
   end
end

function HarpoonDecorator:highlight_group(node)
   self:_build_cache()

   if node.type == "file" then
      if self._cache.files[node.absolute_path] then
         return "NvimTreeHarpoonFile"
      end
   elseif node.type == "directory" then
      if self._cache.ancestors[node.absolute_path] then
         return "NvimTreeHarpoonFile"
      end
   end
end

return HarpoonDecorator