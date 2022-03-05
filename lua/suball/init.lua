local M = {}

--- Returns a substitute command for expr mapping.
--- @param before string: a word before substitution
--- @param after string: a word after substitution
--- @return string: a substitute command expr
function M.map(before, after)
  return require("suball.command").map(before, after)
end

function M.helper(...)
  return require("suball.command").helper(...)
end

return M
