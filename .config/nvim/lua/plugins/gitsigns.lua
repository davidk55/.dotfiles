return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- =============== SETUP ===============
    require("gitsigns").setup({
      -- *************** SETTINGS ***************
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame_opts = {
        delay = 0,
      },
      current_line_blame_formatter = "<summary> - <author> (<author_time:%Y-%m-%d--%H-%M>)",

      -- *************** KEYMAPS ***************
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", ",j", function()
          if vim.wo.diff then
            return ",j"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "[gitsigns] Jump to next hunk" })

        map("n", ",k", function()
          if vim.wo.diff then
            return ",k"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "[gitsigns] Jump to previous hunk" })

        -- Actions
        map({ "n", "v" }, ",s", ":Gitsigns stage_hunk<CR>", { desc = "[gitsigns] Stage selected hunk" })
        map({ "n", "v" }, ",r", ":Gitsigns reset_hunk<CR>", { desc = "[gitsigns] Reset selected hunk" })
        map("n", ",S", gs.stage_buffer, { desc = "[gitsigns] Stage current buffer" })
        map("n", ",u", gs.undo_stage_hunk, { desc = "[gitsigns] Undo last stage of hunk" })
        map("n", ",r", gs.reset_hunk, { desc = "[gitsigns] Reset changes of selected hunk" })
        map("n", ",R", gs.reset_buffer, { desc = "[gitsigns] Reset changes in current buffer" })
        map("n", ",p", gs.preview_hunk, { desc = "[gitsigns] Preview committed state of selected hunk" })
        map("n", ",b", function()
          gs.blame_line({ full = true })
        end, { desc = "[gitsigns] Show git blame for current file" })
        map("n", ",,b", gs.toggle_current_line_blame, { desc = "[gitsigns] Toggle git blame" })
        map("n", ",,d", gs.toggle_deleted, { desc = "[gitsigns] Toggle deleted" })
        map("n", ",d", function()
          gs.diffthis("~")
        end, { desc = "[gitsigns] Diff file" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "[gitsigns] Text object for hunks" })
      end,
    })
  end,
}
