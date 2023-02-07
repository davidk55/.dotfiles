local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local c = ls.choice_node

return {
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
  }),
}
