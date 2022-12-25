local util = require 'gg.utils'
local def = require 'gg.definition'
local ts = require 'gg.treesitter'

local M = {}
local bufnr_output = 0
local ft = vim.o.ft

_G.has_split = false

M.view_function = function()
  -- Test without Create VSplite
  --[[
  if not _G.has_split then
    bufnr_output = util.create_split(ft)
  end

  if bufnr_output == 0 then
    return
  end
  --]]

  local root = ts.tsroot()
  if not root then
    return
  end

  def.tsdef_position(ft, root)
  -- using lsp
  --[[
  if not vim.lsp.buf.server_ready() then
    util.wipe_buf(bufnr_output)
    util.print_lines(bufnr_output, { 'Lsp Not ready' })
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

  util.wipe_buf(bufnr_output)
  util.print_lines(bufnr_output, lines)
--]]
end

-- TODO
--  add setup function
--  toggel layouts(function and parameter)

return M
