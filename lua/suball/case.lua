local M = {}

function M.to_upper(str)
  return M.to_snake(str):upper()
end

function M.is_upper(str)
  return str == str:upper()
end

function M.to_snake(str)
  if M.is_camel(str) then
    return vim.fn.substitute(str, "\\v(\\u)", "_\\l\\1", "g")
  elseif M.is_pascal(str) then
    local camel = M.to_camel(str)
    return M.to_snake(camel)
  elseif M.is_kebab(str) then
    local snake = str:gsub("-", "_")
    return snake
  end
  return str:lower()
end

function M.is_snake(str)
  return str == str:lower()
end

function M.to_camel(str)
  if M.is_pascal(str) then
    return str:sub(1, 1):lower() .. str:sub(2)
  elseif M.is_camel(str) then
    return str
  elseif M.is_kebab(str) then
    local snake = M.to_snake(str)
    return M.to_camel(snake)
  end
  return vim.fn.substitute(str:lower(), "\\v_(.)", "\\u\\1", "g")
end

function M.is_camel(str)
  return vim.fn.match(str, "\\v^\\l+(\\u\\l+)+") ~= -1
end

function M.to_pascal(str)
  local camel = M.to_camel(str)
  return camel:sub(1, 1):upper() .. camel:sub(2)
end

function M.is_pascal(str)
  return vim.fn.match(str, "\\v^(\\u\\l+)+") ~= -1
end

function M.to_kebab(str)
  local kebab = M.to_snake(str):gsub("_", "-")
  return kebab
end

function M.is_kebab(str)
  return vim.fn.match(str, "\\v^(\\l+-\\l+)+") ~= -1
end

return M
