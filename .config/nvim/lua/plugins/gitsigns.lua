return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- =============== SETUP ===============
    require("gitsigns").setup({
      -- **************************** SETTINGS ****************************
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

      -- **************************** KEYMAPS ****************************
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
        end, { expr = true })

        map("n", ",k", function()
          if vim.wo.diff then
            return ",k"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, ",s", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, ",r", ":Gitsigns reset_hunk<CR>")
        map("n", ",S", gs.stage_buffer)
        map("n", ",u", gs.undo_stage_hunk)
        map("n", ",R", gs.reset_buffer)
        map("n", ",p", gs.preview_hunk)
        map("n", ",b", function()
          gs.blame_line({ full = true })
        end)
        map("n", ",,b", gs.toggle_current_line_blame)
        map("n", ",,d", gs.toggle_deleted)
        map("n", ",d", function()
          gs.diffthis("~")
        end)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
