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
      current_line_blame_formatter = "<summary> - <author> (<author_time:%Y-%m-%d--%H-%M>)",
      current_line_blame = true,
      diff_opts = {
        internal = true,
      },

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
            vim.cmd.normal({ ",j", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { expr = true, desc = "[gitsigns] Jump to next hunk" })

        map("n", ",k", function()
          if vim.wo.diff then
            vim.cmd.normal({ ",k", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { expr = true, desc = "[gitsigns] Jump to previous hunk" })

        -- Hunks
        map("n", ",s", gs.stage_hunk, { desc = "[gitsigns] Stage selected hunk" })
        map("n", ",r", gs.reset_hunk, { desc = "[gitsigns] Reset selected hunk" })
        map("n", ",p", gs.preview_hunk, { desc = "[gitsigns] Preview committed state of selected hunk" })
        map("n", ",i", gs.preview_hunk_inline, { desc = "[gitsigns] Preview selected hunk inline" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "[gitsigns] Stage selected hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "[gitsigns] Reset selected hunk" })

        -- Buffer
        map("n", ",S", gs.stage_buffer, { desc = "[gitsigns] Stage current buffer" })
        map("n", ",R", gs.reset_buffer, { desc = "[gitsigns] Reset changes in current buffer" })

        -- Blame
        map("n", ",b", function()
          gs.blame_line({ full = true })
        end, { desc = "[gitsigns] Show git blame for current file" })
        map("n", ",,b", gs.toggle_current_line_blame, { desc = "[gitsigns] Toggle git blame" })

        -- Quickfixlist
        map("n", ",q", gs.setqflist, { desc = "[gitsigns] Open hunk quickfix list (local)" })
        map("n", ",Q", function()
          gs.setqflist("all")
        end, { desc = "[gitsigns] Open hunk location list (global)" })

        -- Diff
        map("n", ",w", gs.toggle_word_diff, { desc = "[gitsigns] Toggle word diff" })
        map("n", ",d", function()
          gs.diffthis("~")
        end, { desc = "[gitsigns] Diff file" })

        -- Text object
        map({ "o", "x" }, "ih", gs.select_hunk, { desc = "[gitsigns] Text object for hunks" })
      end,
    })
  end,
}
