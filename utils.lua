local M = {}

function M.node_to_lines(node, buf)
	buf = buf or vim.api.nvim_get_current_buf()

	local def_start_line, _, def_end_line, _ = node:range()
	local lines = vim.api.nvim_buf_get_lines(buf, def_start_line, def_end_line + 1, true)
	return lines
end

function M.print_lines(buf_output, lines)
	for _, line in ipairs(lines) do
		vim.api.nvim_buf_set_lines(buf_output, -1, -1, true, { line })
	end
end

return M
