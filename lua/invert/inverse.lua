local Inverse = {}

function Inverse:__index(key)
  local lhs, rhs
  for _, v in ipairs(self._inverses) do
    lhs, rhs = v[1], v[2]
    if key == lhs then
      return rhs
    elseif key == rhs then
      return lhs
    end
  end
end

---@param inverses Inverse.InversePrimitive
function Inverse:new(inverses)
  local instance = { _inverses = inverses }
  setmetatable(instance, self)
  return instance
end

setmetatable(Inverse, Inverse)

return Inverse
