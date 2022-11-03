local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local rep = require("luasnip.extras").rep

-- *************************** VSCODE SNIPPETS ***************************
-- loads snippets for various languages
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("typescriptreact", { "html" })

ls.add_snippets("all", {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(0),
    i(1, "cond"),
    t(" ? "),
    i(2, "then"),
    t(" : "),
    i(3, "else"),
  }),
  s("helloo", {
    i(1, "test"),
    t("very testi"),
    i(0),
  }),
  ls.parser.parse_snippet("expa", "this is an expand"),
})

-- *************************** HTML SNIPPETS ***************************
ls.add_snippets("html", {
  s(
    "!",
    fmt(
      [[
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>{}</title
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="{}.css" rel="stylesheet">
  </head>
  <body>
    {}
  </body>
</html>
]],
      {
        i(1),
        i(2, "css/style"),
        i(0),
      }
    )
  ),
  s(".", fmt('<div class="{}">{}</div>', { i(1), i(0) })),
  s("css", fmt('<link rel="stylesheet" href="{}.css">', i(0, "style"))),
})

-- *************************** JAVA SNIPPETS ***************************
ls.add_snippets("java", {
  s("st", fmt("static {}", i(0))),
  s("St", fmt("String {}", i(0))),
  s("pr", fmt("private {}", i(0))),
  s("pu", fmt("public {}", i(0))),
  s("vo", fmt("void {}", i(0))),
  s(
    "main",
    fmt("public class {}{{\n\tpublic static void main(String args) {{\n\t\t{}\n\t}}\n}}", {
      f(function()
        local path = vim.api.nvim_buf_get_name(0)
        local path_parts = vim.split(path, "/", true)
        local file = path_parts[#path_parts]
        local file_parts = vim.split(file, ".", true)
        print(file_parts[1])
        return file_parts[1] or ""
      end),
      i(0),
    })
  ),
  s("sout", fmt("System.out.println({})", i(0))),
  s(
    "fn",
    fmt("{} {} {}({}) {{\n\t{}\n}}", {
      c(1, { t("public"), t("private") }),
      i(2, "void"),
      i(3, "myFunc"),
      i(4, ""),
      i(0),
    })
  ),
  s("lst", fmt("{}[{}.length - 1]", { i(1), rep(1) })),
  -- loops
  s("for", fmt("for({})", i(0))),
  s(
    "fori",
    fmt("for(int {} = 0; {} < {}; {}++) {{\n\t{}\n}}", {
      i(1, "i"),
      rep(1),
      i(2, ""),
      rep(1),
      i(0),
    })
  ),
  s(
    "itar",
    fmt("for(int {} = 0; {} < {}.length; {}++) {{\n\tString {} = {}[{}];\n\t{}\n}}", {
      i(1, "i"),
      rep(1),
      i(2, ""),
      rep(1),
      i(3),
      rep(2),
      rep(1),
      i(0),
    })
  ),
  s(
    "itco",
    fmt("for(Iterator {} = {}.iterator(); {}.hasNext(); ) {{\n\t{} {} = {}.next()\n\t{}\n}}", {
      i(1, "iterator"),
      i(2, "collection"),
      rep(1),
      i(3, "Object"),
      i(4, "next"),
      rep(1),
      i(0),
    })
  ),
})

-- *************************** LATEX SNIPPETS ***************************
ls.add_snippets("tex", {
  s(
    "beg",
    fmt("\\begin{{{}}}\n\t{}\n\\end{{{}}}", {
      i(1),
      i(0),
      rep(1),
    })
  ),
  s(
    "art",
    fmt("\\documentclass{}{{article}}\n{}", {
      c(1, { sn(nil, { t("["), i(1), t("]") }), t("") }),
      i(0),
    })
  ),
})

-- *************************** SETTINGS ***************************
ls.config.set_config({

  history = true,
  update_events = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
})
