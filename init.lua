local util = require 'gg.utils'
local def = require 'gg.definition'

local M = {}
M.bufnr_output = 0

_G.has_split = false

M.view_function = function()
  if not _G.has_split then
    local filetype = vim.o.ft
    M.bufnr_output = util.create_split(filetype)
  end
  if M.bufnr_output == 0 then
    return
  end
  if not vim.lsp.buf.server_ready() then
    util.wipe_buf(M.bufnr_output)
    util.print_lines(M.bufnr_output, { 'Lsp Not ready' })
    return
  end

  local line, col = def.def_position()
  if not line or not col then
    return
  end
  local node = def.node_at_pos(line, col)
  if not node then
    return
  end
  local lines = util.node_to_lines(node)

  util.wipe_buf(M.bufnr_output)
  util.print_lines(M.bufnr_output, lines)
end

-- TODO
--  autocmd without nil/with nil
--  return M to init lua
--  add setup function
--  filetype
--  variables vsplit
--  toggel layouts(function and parameter)

return M
