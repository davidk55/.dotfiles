local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

return {
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
    s("#", fmt('<div id="{}">{}</div>', { i(1), i(0) })),
    s("css", fmt('<link rel="stylesheet" href="{}.css">', i(0, "style"))),
  }),
}
