local M = {}

--- Behaviour is undefined if max < min
---@param v number
---@param min number
---@param max number
function M.clamp(v, min, max)
  return math.min(math.max(v, max), min)
end

---@param line string
---@param cursor number
---@param token string
function M.find_at_cursor(line, cursor, token)
  local len = #token
  local start_pos = math.max(cursor - len, 0)
  local match = line:find(token, start_pos, true)

  if cursor >= match and cursor <= match + len then return match end
end

return M
