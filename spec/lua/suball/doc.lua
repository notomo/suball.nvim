local util = require("genvdoc.util")
local plugin_name = vim.env.PLUGIN_NAME

local example_path = ("./spec/lua/%s/example.lua"):format(plugin_name)

vim.o.runtimepath = vim.fn.getcwd() .. "," .. vim.o.runtimepath
dofile(example_path)

require("genvdoc").generate(plugin_name .. ".nvim", {
  chapters = {
    {
      name = function(group)
        return "Lua module: " .. group
      end,
      group = function(node)
        if not node.declaration then
          return nil
        end
        return node.declaration.module
      end,
    },
    {
      name = "EXAMPLES",
      body = function()
        return util.help_code_block_from_file(example_path, { language = "lua" })
      end,
    },
  },
})

local gen_readme = function()
  local exmaple = util.read_all(example_path)

  local content = ([[
# suball.nvim

This is a plugin that substitutes various cases strings with keeping them cases.

## Example

```lua
%s```]]):format(exmaple)

  util.write("README.md", content)
end
gen_readme()
