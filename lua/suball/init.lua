local Command = require("suball.command").Command

local M = {}

function M.map(before, after)
  return Command.new("map", before, after)
end

function M.helper(...)
  return Command.new("helper", ...)
end

return M
