return {
  "windwp/nvim-autopairs",
  config = function()
    -- =============== SETUP ===============
    require("nvim-autopairs").setup({
      disable_in_macro = true, -- disable when recording or executing a macro
    })

    -- =============== CUSTOM RULES ===============
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    require("nvim-autopairs").add_rules({
      Rule("$", "$", { "tex", "latex" }):with_pair(cond.not_before_regex("%\\", 1)):with_move(function(opts)
        local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
        if prev_char == "\\" then
          return false
        end

        if opts.char == "$" then
          return true
        end

        return false
      end),
    })
  end,
}
