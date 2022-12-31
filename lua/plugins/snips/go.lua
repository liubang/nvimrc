--=====================================================================
--
-- go.lua -
--
-- Created by liubang on 2022/09/03 02:57
-- Last Modified: 2022/09/03 02:57
--
--=====================================================================

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local ai = require "luasnip.nodes.absolute_indexer"
local partial = require("luasnip.extras").partial

local ts_utils = require "nvim-treesitter.ts_utils"
local ts_locals = require "nvim-treesitter.locals"

-- the snip leverage lots of setup/snip from https://github.com/arsham/shark/blob/master/lua/settings/luasnip/go.lua
local is_in_test_file = function()
  local filename = vim.fn.expand "%:p"
  return vim.endswith(filename, "_test.go")
end

local is_in_function = require("lb.ts.go").in_func

local not_in_function = function()
  return not is_in_function()
end

local is_in_test_function = function()
  return is_in_test_file() and is_in_function()
end

local in_test_fn = {
  show_condition = is_in_test_function,
  condition = is_in_test_function,
}

local in_test_file = {
  show_condition = is_in_test_file,
  condition = is_in_test_file,
}

local in_fn = {
  show_condition = is_in_function,
  condition = is_in_function,
}

local not_in_fn = {
  show_condition = not_in_function,
  condition = not_in_function,
}

local query_is_set = false
local function set_query()
  if query_is_set then
    return
  end
  query_is_set = true
  vim.treesitter.set_query(
    "go",
    "LuaSnip_Result",
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
  ]]
  )
end

local go_err_snippet = function(args, _, _, spec)
  local err_name = args[1][1]
  local index = spec and spec.index or nil
  local msg = spec and spec[1] or ""
  if spec and spec[2] then
    err_name = err_name .. spec[2]
  end
  if err_name == "nil" then
    return ls.sn(index, ls.sn(nil, ls.i(1, "nil")))
  end
  return ls.sn(index, {
    ls.c(1, {
      ls.sn(nil, fmt('errors.Wrap({}, "{}")', { ls.t(err_name), ls.i(1, msg) })),
      ls.sn(nil, fmt('errors.Wrapf({}, "{}", {})', { ls.t(err_name), ls.i(1, msg), ls.i(2) })),
      ls.sn(
        nil,
        fmt('internal.GrpcError({},\n\t\tcodes.{}, "{}", "{}", {})', {
          ls.t(err_name),
          ls.i(1, "Internal"),
          ls.i(2, "Description"),
          ls.i(3, "Field"),
          ls.i(4, "fields"),
        })
      ),
      ls.t(err_name),
    }),
  })
end

local function transform(text, info)
  local string_sn = function(template, default)
    info.index = info.index + 1
    return ls.sn(info.index, fmt(template, ls.i(1, default)))
  end
  local new_sn = function(default)
    return string_sn("{}", default)
  end

  -- cutting the name if exists.
  if text:find [[^[^\[]*string$]] then
    text = "string"
  elseif text:find "^[^%[]*map%[[^%]]+" then
    text = "map"
  elseif text:find "%[%]" then
    text = "slice"
  elseif text:find [[ ?chan +[%a%d]+]] then
    return ls.t "nil"
  end

  -- separating the type from the name if exists.
  local type = text:match [[^[%a%d]+ ([%a%d]+)$]]
  if type then
    text = type
  end

  if text == "int" or text == "int64" or text == "int32" then
    return new_sn "0"
  elseif text == "float32" or text == "float64" then
    return new_sn "0"
  elseif text == "error" then
    if not info then
      return ls.t "err"
    end

    info.index = info.index + 1
    return go_err_snippet({ { info.err_name } }, nil, nil, { index = info.index })
  elseif text == "bool" then
    info.index = info.index + 1
    return ls.c(info.index, { ls.i(1, "false"), ls.i(2, "true") })
  elseif text == "string" then
    return string_sn('"{}"', "")
  elseif text == "map" or text == "slice" then
    return ls.t "nil"
  elseif string.find(text, "*", 1, true) then
    return new_sn "nil"
  end

  text = text:match "[^ ]+$"
  if text == "context.Context" then
    text = "context.Background()"
  else
    -- when the type is concrete
    text = text .. "{}"
  end

  return ls.t(text)
end

local get_node_text = vim.treesitter.query.get_node_text
local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
      if idx ~= count - 1 then
        table.insert(result, ls.t { ", " })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function return_value_nodes(info)
  set_query()
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope_tree = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, scope in ipairs(scope_tree) do
    if
      scope:type() == "function_declaration"
      or scope:type() == "method_declaration"
      or scope:type() == "func_literal"
    then
      function_node = scope
      break
    end
  end

  if not function_node then
    return
  end

  local query = vim.treesitter.get_query("go", "LuaSnip_Result")
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
  return ls.t { "" }
end

local make_return_nodes = function(args)
  local info = { index = 0, err_name = args[1][1] }

  return ls.sn(nil, return_value_nodes(info))
end

local create_t_run
create_t_run = function(args)
  return ls.sn(1, {
    ls.c(1, {
      ls.t { "" },
      ls.sn(
        nil,
        fmt('\tt.Run("{}", {}{})\n{}', {
          ls.i(1, "Case"),
          ls.t(args[1]),
          rep(1),
          ls.d(2, create_t_run, ai[1]),
        })
      ),
    }),
  })
end

local mirror_t_run_funcs = function(args)
  local strs = {}
  for _, v in ipairs(args[1]) do
    local name = v:match '^%s*t%.Run%s*%(%s*".*", (.*)%)'
    if name then
      local node = string.format("func %s(t *testing.T) {{\n\tt.Parallel()\n}}\n\n", name)
      table.insert(strs, node)
    end
  end
  local str = table.concat(strs, "")
  if #str == 0 then
    return ls.sn(1, ls.t "")
  end
  return ls.sn(1, fmt(str, {}))
end

-- stylua: ignore start
local snippets = {
  -- Main
  ls.s(
    { trig = "main", name = "Main", dscr = "Create a main function" },
    fmta("func main() {\n\t<>\n}", ls.i(0)),
    not_in_fn
  ),

  -- If call error
  ls.s(
    { trig = "ifc", name = "if call", dscr = "Call a function and check the error" },
    fmt(
      [[
        {val}, {err1} := {func}({args})
        if {err2} != nil {{
          return {err3}
        }}
        {finally}
      ]], {
        val     = ls.i(1, { "val" }),
        err1    = ls.i(2, { "err" }),
        func    = ls.i(3, { "func" }),
        args    = ls.i(4),
        err2    = rep(2),
        err3    = ls.d(5, make_return_nodes, { 2 }),
        finally = ls.i(0),
    }),
    in_fn
  ),

  -- if err:=call(); err != nil { return err }
  ls.s(
    { trig = "ifce", name = "if call err inline", dscr = "Call a function and check the error inline" },
    fmt(
      [[
        if {err1} := {func}({args}); {err2} != nil {{
          return {err3}
        }}
        {finally}
      ]], {
        err1    = ls.i(1, { "err" }),
        func    = ls.i(2, { "func" }),
        args    = ls.i(3, { "args" }),
        err2    = rep(1),
        err3    = ls.d(4, make_return_nodes, { 1 }),
        finally = ls.i(0),
    }),
    in_fn
  ),

  -- Function
  ls.s(
    { trig = "fn", name = "Function", dscr = "Create a function or a method" },
    fmt(
      [[
        // {name1} {desc}
        func {rec}{name2}({args}) {ret} {{
          {finally}
        }}
      ]], {
        name1 = rep(2),
        desc  = ls.i(5, "description"),
        rec   = ls.c(1, {
          ls.t(""),
          ls.sn(nil, fmt("({} {}) ", {
            ls.i(1, "r"),
            ls.i(2, "receiver"),
          })),
        }),
        name2 = ls.i(2, "Name"),
        args  = ls.i(3),
        ret   = ls.c(4, {
          ls.i(1, "error"),
          ls.sn(nil, fmt("({}, {}) ", {
            ls.i(1, "ret"),
            ls.i(2, "error"),
          })),
        }),
        finally = ls.i(0),
    }),
    not_in_fn
  ),

  -- If error
  ls.s(
    { trig = "ife", name = "If error, choose me!", dscr = "If error, return wrapped with dynamic node" },
    fmt("if {} != nil {{\n\treturn {}\n}}\n{}", {
      ls.i(1, "err"),
      ls.d(2, make_return_nodes, { 1 }, { user_args = { { "a1", "a2" } } }),
      ls.i(0),
    }),
    in_fn
  ),

  -- errors.Wrap
  ls.s(
    { trig = "erw", dscr = "errors.Wrap" },
    fmt([[errors.Wrap({}, "{}")]], {
      ls.i(1, "err"),
      ls.i(2, "failed to"),
    })
  ),

  -- errors.Wrapf
  ls.s(
    { trig = "erwf", dscr = "errors.Wrapf" },
    fmt([[errors.Wrapf({}, "{}", {})]], {
      ls.i(1, "err"),
      ls.i(2, "failed %v"),
      ls.i(3, "args"),
    })
  ),

  -- for select
  ls.s(
    { trig = "fsel", dscr = "for select" },
    fmt([[
for {{
	  select {{
        case {} <- {}:
			      {}
        default:
            {}
	  }}
}}
]], {
      ls.c(1, {ls.i(1, "ch"), ls.i(2, "ch := ")}),
      ls.i(2, "ch"),
      ls.i(3, "break"),
      ls.i(0, ""),
    })
  ),

  ls.s(
    { trig = "for([%w_]+)", regTrig = true, hidden = true },
	fmt(
		[[
for  {} := 0; {} < {}; {}++ {{
  {}
}}
{}
    ]],
		{
			ls.d(1, function(_, snip)
				return ls.sn(1, ls.i(1, snip.captures[1]))
			end),
			rep(1),
			ls.c(2, { ls.i(1, "num"), ls.sn(1, { ls.t("len("), ls.i(1, "arr"), ls.t(")") }) }),
			rep(1),
			ls.i(3, "// TODO:"),
			ls.i(4),
		}
	), in_fn
),
  -- type switch
  ls.s(
    { trig = "tysw", dscr = "type switch" },
    fmt([[
switch {} := {}.(type) {{
    case {}:
        {}
    default:
        {}
}}
]], {
      ls.i(1, "v"),
      ls.i(2, "i"),
      ls.i(3, "int"),
      ls.i(4, 'fmt.Println("int")'),
      ls.i(0, ""),
    })
  ),
  -- fmt.Sprintf
  ls.s(
    { trig = "spn", dscr = "fmt.Sprintf" },
    fmt([[fmt.Sprintf("{}%{}", {})]], {
      ls.i(1, "msg "),
      ls.i(2, "+v"),
      ls.i(2, "arg"),
    })
  ),

  -- build tags
  ls.s(
    { trig = "//tag", dscr = "// +build tags" },
    fmt([[// +build:{}{}]], {
      ls.i(1, "integration"),
      ls.i(2, ",unit"),
    })
  ),

  -- Nolint
  ls.s(
    { trig = "nolt", dscr = "ignore linter" },
    fmt([[// nolint:{}{}]], {
      ls.i(1, "funlen"),
      ls.i(2, ",cyclop"),
    })
  ),

  -- defer recover
  ls.s(
    { trig = "dfr", dscr = "defer recover" },
    fmt(
      [[
        defer func() {{
            if err := recover(); err != nil {{
       	        {}
            }}
        }}()]], {
      ls.i(1, ""),
    })
  ),

  -- Allocate Slices and Maps
  ls.s(
    { trig = "mk", name = "Make", dscr = "Allocate map or slice" },
    fmt("{} {}= make({})\n{}", {
      ls.i(1, "name"),
      ls.i(2),
      ls.c(3, {
        fmt("[]{}, {}", { ls.r(1, "type"), ls.i(2, "len") }),
        fmt("[]{}, 0, {}", { ls.r(1, "type"), ls.i(2, "len") }),
        fmt("map[{}]{}, {}", { ls.r(1, "type"), ls.i(2, "values"), ls.i(3, "len") }),
      }, {
        stored = { -- FIXME: the default value is not set.
          type = ls.i(1, "type"),
        },
      }),
      ls.i(0),
    }),
    in_fn
  ),

  -- Test Cases
  ls.s(
    { trig = "tcs", dscr = "create test cases for testing" },
    fmta(
      [[
        tcs := map[string]struct {
        	<>
        } {
        	// Test cases here
        }
        for name, tc := range tcs {
        	tc := tc
        	t.Run(name, func(t *testing.T) {
        		<>
        	})
        }
      ]],
      { ls.i(1), ls.i(2) }
    ),
    in_test_fn
  ),

  -- gRPC Error
  ls.s(
    { trig = "gerr", dscr = "Return an instrumented gRPC error" },
    fmt('internal.GrpcError({},\n\tcodes.{}, "{}", "{}", {})', {
      ls.i(1, "err"),
      ls.i(2, "Internal"),
      ls.i(3, "Description"),
      ls.i(4, "Field"),
      ls.i(5, "fields"),
    }),
    in_fn
  ),

  ls.s(
    { trig = "hf", name = "http.HandlerFunc", dscr = "http handler" },
    fmt( [[
    func {}(w http.ResponseWriter, r *http.Request) {{
        {}
    }}
]], {
      ls.i(1, "handler"),
      ls.i(2, [[fmt.Fprintf(w, "hello world")"]]),
    })
  ),

  -- deep equal
  ls.s(
    { trig = "deq", name = "reflect Deep equal", dscr = "Compare with deep equal and print error" },
    fmt([[
if !reflect.DeepEqual({}, {}) {{
	_, file, line, _ := runtime.Caller(0)
    fmt.Printf("%s:%d:\n\n\texp: %#v\n\n\tgot: %#v\n\n", filepath.Base(file), line, {}, {})
    t.FailNow()
}}]] , {
      ls.i(1, "expected"),
      ls.i(2, "got"),
      rep(1),
      rep(2),
    }),
    in_test_fn
  ),
  -- Create Mocks
  ls.s(
    { trig = "mock", name = "Mocks create", dscr = "Create a mock with NewFactory" },
    fmt("{} := &mocks.{}({})", {
      ls.i(1, "m"),
      ls.i(2, "NewFactory"),
      ls.i(3, "t"),
    }),
    in_test_fn
  ),

  -- Http request with defer close
  ls.s(
       { trig = 'hreq', name = "http request with defer close", dscr = "create a http request with defer body close" },
    fmt([[
  {}, {} := http.{}("http://{}:" + {} + "/{}")
	if {} != nil {{
		log.Fatalln({})
	}}
	_ = {}.Body.Close()

    ]], {
        ls.i(1, "resp"),
        ls.i(2, "err"),
        ls.c(3, {ls.i(1, "Get"), ls.i(2, "Post"), ls.i(3, "Patch")}),
        ls.i(4, "localhost"),
        ls.i(5, [["8080"]]),
        ls.i(6, "path"),
        rep(2),
        rep(2),
        rep(1),
      }
    ),
    in_test_fn
  ),

  -- Go CMP
  ls.s(
    { trig = "gocmp", dscr = "Create an if block comparing with cmp.Diff" },
    fmt(
      [[
        if diff := cmp.Diff({}, {}); diff != "" {{
        	t.Errorf("(-want +got):\\n%s", diff)
        }}
      ]], {
        ls.i(1, "want"),
        ls.i(2, "got"),
    }),
    in_test_fn
  ),

  -- Require NoError
  ls.s(
    { trig = "noerr", name = "Require No Error", dscr = "Add a require.NoError call" },
    ls.c(1, {
      ls.sn(nil, fmt("require.NoError(t, {})", { ls.i(1, "err") })),
      ls.sn(nil, fmt('require.NoError(t, {}, "{}")', { ls.i(1, "err"), ls.i(2) })),
      ls.sn(nil, fmt('require.NoErrorf(t, {}, "{}", {})', { ls.i(1, "err"), ls.i(2), ls.i(3) })),
    }),
    in_test_fn
  ),

  -- Assert equal
  ls.s(
    { trig = "aeq", name = "Assert Equal", dscr = "Add assert.Equal" },
    ls.c(1, {
      ls.sn(nil, fmt('assert.Equal(t, {}, {})', { ls.i(1, "got"), ls.i(2, "want") })),
      ls.sn(nil, fmt('assert.Equalf(t, {}, {}, "{}", {})', { ls.i(1, "got"), ls.i(2, "want"), ls.i(3, "got %v not equal to want"), ls.i(4, "got") })),
    }),
    in_test_fn
  ),

  -- Subtests
  ls.s(
    { trig = "test", name = "Test & Subtest", dscr = "Create subtests and their function stubs" },
    fmta("func <>(t *testing.T) {\n<>\n}\n\n <>", {
      ls.i(1),
      ls.d(2, create_t_run, ai({ 1 })),
      ls.d(3, mirror_t_run_funcs, ai({ 2 })),
    }),
    in_test_file
  ),

  -- bench test
  ls.s(
    { trig = "bench", name = "bench test cases ", dscr = "Create benchmark test" },
    fmt([[
	    func Benchmark{}(b *testing.B) {{
	        for i := 0; i < b.N; i++ {{
	     	    {}({})
	        }}
	    }}]]
    , {
      ls.i(1, "MethodName"),
      rep(1),
      ls.i(2, "args")
    }),
    in_test_file
  ),


  -- Stringer
  ls.s(
    { trig = "strigner", name = "Stringer", dscr = "Create a stringer go:generate" },
    fmt("//go:generate stringer -type={} -output={}_string.go", {
      ls.i(1, "Type"),
      partial(vim.fn.expand, "%:t:r"),
    })
  ),
}

ls.add_snippets("go", snippets)
-- stylua: ignore end
