local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

return {
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
  }),
}
