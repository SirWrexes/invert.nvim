---@alias Inverse.InversePrimitive table<string, string>

---@class Invert.Config
---@field inverses Inverse.InversePrimitive
---@field inverses_by_ft table<string, Inverse.InversePrimitive>
local config = {
  inverses = {
    ["cringe"] = "based",
    ["true"] = "false",
    ["or"] = "and",
    ["+"] = "-",
    ["&&"] = "||",
    [">"] = "<",
    [">="] = "<=",
    ["=="] = "!=",
    ["==="] = "!==",
    ["multi-word"] = "single-word",
  },
  inverses_by_ft = {
    lua = {
      ["=="] = "~=",
    },
  },
}

---@class Invert
local M = {}

---@type Invert.Config
M.config = config

local function get_outer_tokens(inner) end

local function get_token(token)
  local inner = token or vim.fn.expand("<cword>")
  local outer = get_outer_tokens(inner)
end

M.is_known_inverse = function(config) end

---@param args Invert.Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.invert = function() end

return M
