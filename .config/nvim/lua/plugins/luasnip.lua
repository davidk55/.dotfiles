return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
    config = function()
      -- loads snippets from: https://github.com/rafamadriz/friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- use snippets like c => const {1} of javascript also for .ts and .tsx files
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript" })
      require("luasnip").filetype_extend("php", { "html" })

      -- load my custom snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/lua/plugins/snippets" } })

      -- =============== GLOBAL FUNCTIONS ===============
      _G.tab_complete = function()
        if require("luasnip").expand_or_jumpable() then
          return "<cmd>lua require'luasnip'.jump(1)<CR>"
        else
          return "<Tab>"
        end
      end
      _G.s_tab_complete = function()
        if require("luasnip").jumpable(-1) then
          return "<cmd>lua require'luasnip'.jump(-1)<CR>"
        else
          return "<S-Tab>"
        end
      end

      _G.ctrl_n_next_choice = function()
        if require("luasnip").choice_active then
          return "<Plug>luasnip-next-choice"
        else
          return "<C-n>"
        end
      end

      _G.ctrl_p_prev_choice = function()
        if require("luasnip").choice_active then
          return "<Plug>luasnip-prev-choice"
        else
          return "<C-p>"
        end
      end

      -- =============== MAPPINGS ===============
      vim.keymap.set({ "i", "s" }, "<Tab>", "v:lua.tab_complete()", { expr = true, desc = "[luasnip] Tab complete" })
      vim.keymap.set(
        { "i", "s" },
        "<S-Tab>",
        "v:lua.s_tab_complete()",
        { expr = true, desc = "[luasnip] Shift tab complete" }
      )
      vim.keymap.set(
        { "i", "s" },
        "<C-n>",
        "v:lua.ctrl_n_next_choice()",
        { expr = true, desc = "[luasnip] Next choice" }
      )
      vim.keymap.set(
        { "i", "s" },
        "<C-p>",
        "v:lua.ctrl_p_prev_choice()",
        { expr = true, desc = "[luasnip] Previous choice" }
      )
    end,
  },
}
