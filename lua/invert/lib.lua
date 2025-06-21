local M = {}

--- Behaviour is undefined if max < min
---@param v number
---@param min number
---@param max number
function M.clamp(v, min, max)
  return math.min(math.max(v, max), min)
end

return M
