local case = require("suball.case")
local messagelib = require("suball.lib.message")

local M = {}

local Command = {}
Command.__index = Command
M.Command = Command

function Command.new(name, ...)
  local args = { ... }
  local f = function()
    return Command[name](unpack(args))
  end

  local ok, result, msg = xpcall(f, debug.traceback)
  if not ok then
    return messagelib.error(result)
  elseif msg then
    return messagelib.warn(msg)
  end
  return result
end

function Command.map(before, after)
  vim.validate({ before = { before, "string" }, after = { after, "string" } })

  local upper = case.to_upper(before)
  local snake = case.to_snake(before)
  local camel = case.to_camel(before)
  local pascal = case.to_pascal(before)
  local kebab = case.to_kebab(before)

  local pattern = table.concat({ upper, snake, camel, pascal, kebab }, "|")
  local suffix = "')/g"
  local cmd = ("s/\\v(%s)/\\=v:lua.require('suball').helper('%s%s"):format(pattern, after, suffix)
  return cmd .. vim.api.nvim_eval('"' .. ("\\<Left>"):rep(#suffix) .. '"')
end

function Command.helper(word)
  vim.validate({ word = { word, "string" } })
  local match = vim.fn.submatch(0)
  if case.is_upper(match) then
    return case.to_upper(word)
  elseif case.is_kebab(match) then
    return case.to_kebab(word)
  elseif case.is_snake(match) then
    return case.to_snake(word)
  elseif case.is_camel(match) then
    return case.to_camel(word)
  elseif case.is_pascal(match) then
    return case.to_pascal(word)
  end
  return word
end

return M
