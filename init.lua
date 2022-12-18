local util = require 'gg.utils'
local def = require 'gg.definition'

local M = {}
M.bufnr_output = 0

_G.has_split = false
M.creat_split = function()
  -- create a vnew or new
  -- set as unmodifier, no buckuo...
  -- setft with ft from buf0
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

  if win and vim.api.nvim_win_is_valid(start_win) then
    vim.api.nvim_set_current_win(start_win)
  else
    print 'no win'
  end

  _G.has_split = true
  return buf
end

M.view_function = function()
  if not _G.has_split then
    M.bufnr_output = M.creat_split()
  end
  if M.bufnr_output == 0 then
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
