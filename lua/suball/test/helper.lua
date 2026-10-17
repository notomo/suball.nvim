local helper = require("ntf.helper")
local plugin_name = helper.get_module_root(...)

helper.root = helper.find_plugin_root(plugin_name)

function helper.before_each() end

function helper.after_each() end

function helper.set_lines(lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(lines, "\n"))
end

vim.api.nvim_set_option_value(
  "packpath",
  vim.env.TESTPACK_PACKPATH or vim.fs.joinpath(helper.root, "spec/.shared/packages"),
  { operation = "prepend" }
)
require("assertlib").register(require("ntf.assert").register)

local assert = require("ntf.assert")

assert.register_eq("lines", function()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end)

function helper.typed_assert(raw_assert)
  local x = require("assertlib").typed(raw_assert)
  ---@cast x +{lines:fun(want)}
  return x
end

return helper
