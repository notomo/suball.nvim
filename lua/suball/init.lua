local Command = require("suball.command").Command

local M = {}

function M.map(before, after)
  return Command.new("map", before, after)
end

return M
