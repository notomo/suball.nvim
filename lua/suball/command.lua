local Case = require("suball.case")

local M = {}

function M.map(before, after)
  vim.validate({ before = { before, "string" }, after = { after, "string" } })

  local upper = Case.to_upper(before)
  local snake = Case.to_snake(before)
  local camel = Case.to_camel(before)
  local pascal = Case.to_pascal(before)
  local kebab = Case.to_kebab(before)

  local pattern = table.concat({ upper, snake, camel, pascal, kebab }, "|")
  local suffix = "')/g"
  local cmd = ("s/\\v(%s)/\\=v:lua.require('suball').helper('%s%s"):format(pattern, after, suffix)
  return cmd .. ("<Left>"):rep(#suffix)
end

function M.helper(word)
  vim.validate({ word = { word, "string" } })
  local match = vim.fn.submatch(0)
  if Case.is_upper(match) then
    return Case.to_upper(word)
  elseif Case.is_kebab(match) then
    return Case.to_kebab(word)
  elseif Case.is_snake(match) then
    return Case.to_snake(word)
  elseif Case.is_camel(match) then
    return Case.to_camel(word)
  elseif Case.is_pascal(match) then
    return Case.to_pascal(word)
  end
  return word
end

return M
