local M = {}

function M.node_to_lines(node, buf)
  buf = buf or vim.api.nvim_get_current_buf()

  local def_start_line, _, def_end_line, _ = node:range()
  -- test if def is in this buf or not
  -- TODO , get the definition form any file in system or cloud
  local lines = vim.api.nvim_buf_get_lines(buf, def_start_line, def_end_line + 1, true) or {}
  return lines
end

function M.print_lines(buf_output, lines)
  for _, line in ipairs(lines) do
    vim.api.nvim_buf_set_lines(buf_output, -1, -1, true, { line })
  end
end

function M.wipe_buf(buf_output)
  vim.api.nvim_buf_set_lines(buf_output, 0, -1, true, {})
end

function M.create_split(filetype)
  local start_win = vim.api.nvim_get_current_win()

  vim.api.nvim_command 'botright vnew' -- We open a new vertical window at the far right
  local win = vim.api.nvim_get_current_win() -- We save our navigation window handle...
  local buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.

  -- We should name our buffer. All buffers in vim must have unique names.
  -- The easiest solution will be adding buffer handle to it
  -- because it is already unique and it's just a number.
  vim.api.nvim_buf_set_name(buf, 'Output' .. buf)

  -- Now we set some options for our buffer.
  -- nofile prevent mark buffer as modified so we never get warnings about not saved changes.
  -- Also some plugins treat nofile buffers different.
  -- For example coc.nvim don't triggers aoutcompletation for these.
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  -- We do not need swapfile for this buffer.
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  -- And we would rather prefer that this buffer will be destroyed when hide.
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  -- It's not necessary but it is good practice to set custom filetype.
  -- This allows users to create their own autocommand or colorschemes on filetype.
  -- and prevent collisions with other plugins.
  -- vim.api.nvim_buf_set_option(buf, 'filetype', 'nvim-oldfile')

  -- For better UX we will turn off line wrap and turn on current line highlight.
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_win_set_option(win, 'cursorline', true)
  vim.api.nvim_buf_set_option(buf, "filetype", filetype )

  if win and vim.api.nvim_win_is_valid(start_win) then
    vim.api.nvim_set_current_win(start_win)
  else
    print 'no win'
  end

  _G.has_split = true
  return buf
end

return M
