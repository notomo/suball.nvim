local example_path = "./spec/lua/suball/example.vim"

vim.o.runtimepath = vim.fn.getcwd() .. "," .. vim.o.runtimepath
vim.cmd([[source ]] .. example_path)

require("genvdoc").generate("suball.nvim", {
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
        return require("genvdoc.util").help_code_block_from_file(example_path)
      end,
    },
  },
})

local gen_readme = function()
  local f = io.open(example_path, "r")
  local exmaple = f:read("*a")
  f:close()

  local content = ([[
# suball.nvim

This is a plugin that substitutes various cases strings with keeping them cases.

## Example

```vim
%s```]]):format(exmaple)

  local readme = io.open("README.md", "w")
  readme:write(content)
  readme:close()
end
gen_readme()
