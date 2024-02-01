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
```lua
P = function(v)
    print(type(v))
    local v_type = type(v)
    if v_type == 'number' or v_type == 'string' or v_type == 'boolean' then
        print(v)
    elseif v_type == 'function' then
        print(vim.inspect(v))
    else -- v_type == 'userdata'
        print(vim.inspect(getmetatable(v)))
    end
end
local node = vim.treesitter.get_parser():parse()[1]:root()::descendant_for_range(1,1)
```

```lua
<function 1>: userdata>
<function 2>: function>
<function 3>: boolean>

P(node userdata)                      ==> <1>{foo=<function 1>,bar=<function 2>,baz=<function 3>}
P(node:foo())                         ==> "Heloo word"
P(node -> bar)                        ==> ??? maybe  node.bar or node:baz
P(node -> baz)                        ==> ??? maybe  node.baz or node:baz
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
