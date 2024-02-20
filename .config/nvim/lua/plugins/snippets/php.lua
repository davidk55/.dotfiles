local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("ph", fmt("<?php {} ?>", i(0))),
  s("php", fmt("<?php\n{}\n?>", i(0))),
}
