---@meta

---@class Invert.Pairs
---@field [string] string

---@class Invert.Inverses
---@field pairs   Invert.Pairs
---@field longest number
---@overload fun(inverses: Invert.Pairs): Invert.Inverses

---@class Invert.Inverse.Match.Token
---@field text string
---@field start number 0-indexed
---@field end   number 0-indexed

---@class Invert.Inverses.Match
---@field token     string
---@field inverse   string
---@field row       number
---@field start_col number 0-indexed
---@field end_col   number 0-indexed
