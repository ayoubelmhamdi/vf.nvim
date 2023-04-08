# Testing
`vnew` should open `vsplit` with `bufnr=5`
```vim
:vnew
```
```lua
return {
  'ayoubelmhamdi/vf.nvim',
  config = function()
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      pattern = { '*.rs', '*.lua' },
      callback = function()
        vim.cmd [[silent! lua require("vf").view_function()]]
      end,
    })
  end,
}
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
