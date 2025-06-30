---@class Invert
local M = {}

---@class Invert.Config
---@field inverses?       Invert.Pairs[]
---@field inverses_by_ft? table<string, Invert.Pairs[]>
M.defaults = {
  inverses = {
    ['true'] = 'false',
    ['or'] = 'and',
    ['*'] = '/',
    ['+'] = '-',
    ['&&'] = '||',
    ['>'] = '<',
    ['>='] = '<=',
    ['=='] = '!=',
  },
  inverses_by_ft = {
    lua = {
      ['=='] = '~=',
    },
    jslike = {
      ['==='] = '!==',
    },
  },
}

---@type Invert.Config
M.config = vim.tbl_deep_extend('force', {}, M.defaults)

--- @param msg string
function M.banner(msg)
  return '[invert.nvim] ' .. msg
end

--- @param msg string
function M.warn(msg)
  vim.notify(M.banner(msg), vim.log.levels.WARN)
end

---@param opts Invert.Config?
function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})

  local Inverses = require 'invert.Inverses'
  local global, ft = M.config.inverses or {}, M.config.inverses_by_ft or {}
  local jslike = vim.tbl_extend('force', global, ft.jslike or {})
  local iv = {}

  iv[1] = Inverses(M.config.inverses)
  iv.javascript = Inverses(vim.tbl_extend('force', jslike, ft.javascript or {}))
  iv.typescript = Inverses(vim.tbl_extend('force', jslike, ft.typescript or {}))
  iv.javascriptreact =
    Inverses(vim.tbl_extend('force', jslike, ft.javascriptreact or {}))
  iv.typescriptreact =
    Inverses(vim.tbl_extend('force', jslike, ft.typescriptreact or {}))

  M.inverses = iv
end

--- @param window? number Default: 0 (current)
function M.invert_at_cursor(window)
  window = window or 0

  local iv = M.inverses[vim.bo.ft] or M.inverses[1]
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window))
  local match = iv:find_at_cursor(line, col)

  if not match then return M.warn 'Found nothing to invert' end
  vim.api.nvim_buf_set_text(
    0,
    row - 1,
    match.start_col,
    row - 1,
    match.end_col,
    { match.inverse }
  )
end

return M
