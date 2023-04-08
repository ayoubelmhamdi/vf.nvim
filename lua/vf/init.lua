local util = require("gg.utils")
local def = require("gg.definition")

local bufnr_output = 5
local bufnr = 0

local line, col = def.def_position()
if not line or not col then
	return
end
local node = def.node_at_pos(line, col)
local lines = util.node_to_lines(node)

util.print_lines(bufnr_output, lines)

-- TODO
--  autocmd without nil/with nil
--  return M to init lua
--  add setup function
--  filetype
--  variables vsplit
--  toggel layouts(function and parameter)
