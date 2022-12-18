local M = {}

function M.def_position(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params()
  if not params then
    return
  end

  local results_lsp = vim.lsp.buf_request_sync(0, 'textDocument/definition', params)
  if
    not results_lsp
    or not results_lsp[1]
    or not results_lsp[1].result
    or not results_lsp[1].result[1]
    or vim.tbl_isempty(results_lsp)
  then
    -- Test by print
    -- print 'No results from textDocument/definition'
    return
  end

  local start = results_lsp[1].result[1].targetRange.start

  local col = start.character
  local line = start.line

  return line, col
end

function M.node_at_pos(start_line, start_col, buf)
  buf = buf or vim.api.nvim_get_current_buf()
  start_col = start_col - 1

  local tree = vim.treesitter.get_parser()

  if not tree then
    return nil
  end

  local parse = tree:parse()
  local root = parse[1]:root()
  local node = root:descendant_for_range(start_line, start_col, start_line, start_col)

  return node
end

return M
