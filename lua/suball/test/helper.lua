local helper = require("vusted.helper")
local plugin_name = helper.get_module_root(...)

helper.root = helper.find_plugin_root(plugin_name)

function helper.before_each() end

function helper.after_each()
  helper.cleanup()
  helper.cleanup_loaded_modules(plugin_name)
end

function helper.set_lines(lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(lines, "\n"))
end

vim.opt.packpath:prepend(vim.fs.joinpath(helper.root, "spec/.shared/packages"))
require("assertlib").register(require("vusted.assert").register)

local asserts = require("vusted.assert").asserts

asserts.create("lines"):register_eq(function()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end)

function helper.typed_assert(assert)
  local x = require("assertlib").typed(assert)
  ---@cast x +{lines:fun(want)}
  return x
end

return helper
