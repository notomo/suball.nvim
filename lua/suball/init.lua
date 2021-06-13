local Command = require("suball.command").Command

local M = {}

function M.map(before, after)
  return Command.new("map", before, after)
end

function M.input(before, after)
  return Command.new("input", before, after)
end

-- NOTE: global for using from v:lua
function _G._suball_helper(is_one_word, match, word)
  return Command.new("helper", is_one_word, match, word)
end

return M
