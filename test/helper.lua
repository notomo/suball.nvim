local M = {}

M.root = vim.fn.getcwd()

M.command = function(cmd)
  vim.api.nvim_command(cmd)
end

M.before_each = function()
end

M.after_each = function()
  M.command("tabedit")
  M.command("tabonly!")
  M.command("silent! %bwipeout!")
  print(" ")
end

M.set_lines = function(lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(lines, "\n"))
end

M.cursor = function()
  return {vim.fn.line("."), vim.fn.col(".")}
end

local assert = require("luassert")
local AM = {}

AM.lines = function(expected)
  local actual = table.concat(vim.fn.getbufline("%", 0, "$"), "\n")
  local msg = string.format("lines should be %s, but actual: %s", expected, actual)
  assert.equals(expected, actual, msg)
end

M.assert = AM

return M
