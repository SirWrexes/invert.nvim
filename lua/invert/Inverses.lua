---@class Invert.Inverses
local Inverses = {}

local InstanceMeta = {
  __index = Inverses,
  __len = function(self)
    return self.longest
  end,
}

setmetatable(Inverses, {
  __index = Inverses,
  __call = function(self, inverses)
    local instance = {
      longest = 0,
      pairs = {},
    }

    local llen, rlen
    for lhs, rhs in pairs(inverses) do
      llen, rlen = #lhs, #rhs
      if instance.longest < llen then instance.longest = llen end
      if instance.longest < rlen then instance.longest = rlen end
      instance.pairs[lhs] = rhs
      instance.pairs[rhs] = lhs
    end

    return setmetatable(instance, InstanceMeta)
  end,
})

--- Get the inverse of a known token, or `nil` if unknown
--- @param token string
--- @return string?
function Inverses:get(token)
  return self.pairs[token]
end

--- Find the first known inverseable token in a line
--- @param line string
--- @param col  number 0-indexed cursor column
--- @return Invert.Inverses.Match?
function Inverses:find_at_cursor(line, col)
  local i, j

  for token, inverse in pairs(self.pairs) do
    i, j = line:find(token, 1, true)
    if i then
      i = i - 1
      j = j - 1
      if col >= i and col <= j then
        return {
          token = token,
          inverse = inverse,
          row = 0,
          start_col = i,
          end_col = j,
        }
      end
    end
  end
end

return Inverses
