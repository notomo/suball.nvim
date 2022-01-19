local Command = require("suball.command").Command

local M = {}

--- Returns a substitute command for expr mapping.
--- @param before string: a word before substitution
--- @param after string: a word after substitution
--- @return string: a substitute command expr
function M.map(before, after)
  return Command.new("map", before, after)
end

function M.helper(...)
  return Command.new("helper", ...)
end

return M
