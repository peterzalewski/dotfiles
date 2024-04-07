return {
   name = "pants test",
   params = {
      args = {
         type = "string",
         name = "target",
         optional = false,
         validate = function(value)
            return true
         end,
      },
   },
   builder = function(params)
      return {
         cmd = { "./pants", "test" },
         args = { params.args },
         components = { { "on_output_quickfix", open = true }, "default" },
      }
   end,
}
