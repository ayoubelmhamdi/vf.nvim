local M = {}

function M.tsroot(buf)
  buf = buf or vim.api.nvim_get_current_buf()

  local tree = vim.treesitter.get_parser()

  if not tree then
    return nil
  end

  local parse = tree:parse()
  local root = parse[1]:root()

  return root
end

function M.tsquery(ft, txt_query, buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local query = vim.treesitter.parse_query(ft, txt_query)

  return query
end

return M
