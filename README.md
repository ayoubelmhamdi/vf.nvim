# Testing

```lua
vim.keymap.set('n', '<space>s', function()
  -- package.loaded.gg = nil
  -- vim.cmd 'w'
  R 'gg'
  require('vf').view_function()
end, {})

vim.keymap.set('n', '<space>e', function()
  require('vf').view_function()
end, {})
--
-- Create an autocommand group
local group = vim.api.nvim_create_augroup('delete_no_name_buffers', { clear = true })

-- Create an autocommand to delete buffers with the name '[No Name]'
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
  pattern = '*',
  group = group,
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname == '' then
        vim.bo[bufnr].bufhidden = 'delete'
      end
    end
  end,
})

```

### Inspect userdata :
`type`: is `userdata`
```
P(vim.inspect(getmetatable(userdata))) => <1>{}
P(getmetatable(userdata))              => ""
P(userdata.iddd)                       ==> 1
P(userdata:iddd())                     ==> 1
```
### node
- `type`: `function_definition`/`identifire`...
- to get the `range`:
```lua
local start_col  = start_col  - 1
local node = root:descendant_for_range(start_line, start_col, start_line, start_col)
print(node:range())  => { 22  3  27 4}
local get_start_line, get_start_col, get_end_line, get_end_col =	node:range()
```
You get ==> `get_end_line = 27` ...

```lua
-- parser:
local parser = vim.treesitter.get_parser(bufnr)`
```
```lua
-- parse
local parse = parser:parse()
```

```lua
-- root
   local root = parse[1]:root()
   local node = root:descendant_for_range(start_line, start_col, end_line, end_col)
```
