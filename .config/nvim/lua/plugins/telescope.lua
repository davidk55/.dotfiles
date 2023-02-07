return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local actions = require("telescope.actions")

    -- =============== SETUP ===============
    require("telescope").setup({

      defaults = {
        mappings = {
          -- insert mode mappings
          i = {
            ["<C-s>"] = actions.select_horizontal,
            ["<C-w>t"] = actions.select_tab,
          },

          -- normal mode mappings
          n = {
            ["<C-s>"] = actions.select_horizontal,
            ["dd"] = actions.delete_buffer,
          },
        },
      },
    })

    -- =============== LOAD EXTENSIONS ===============
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("projects")

    -- =============== MAPPINGS ===============
    -- File Pickers
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { noremap = true })
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { noremap = true })

    -- Vim Pickers
    vim.keymap.set("n", "<leader>fb", require("telescope.builtin").oldfiles, { noremap = true })
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { noremap = true })
    vim.keymap.set("n", "<leader>f/", require("telescope.builtin").search_history, { noremap = true })
    vim.keymap.set("n", "<leader>f:", require("telescope.builtin").command_history, { noremap = true })
    vim.keymap.set("n", '<leader>f"', require("telescope.builtin").registers, { noremap = true })
    vim.keymap.set("n", "<leader>fr", require("telescope.builtin").commands, { noremap = true })
    vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, { noremap = true })
    vim.keymap.set("n", "<leader>fc", require("telescope.builtin").colorscheme, { noremap = true })
    vim.keymap.set("n", "<leader>fl", require("telescope.builtin").reloader, { noremap = true })
    vim.keymap.set("n", "<leader>f`", require("telescope.builtin").marks, { noremap = true })
    vim.keymap.set("n", "<leader>fm", require("telescope.builtin").man_pages, { noremap = true })
    vim.keymap.set("n", "<leader>ft", require("telescope.builtin").treesitter, { noremap = true })

    -- Git Pickers
    vim.keymap.set("n", ",fs", require("telescope.builtin").git_status, { noremap = true })
    vim.keymap.set("n", ",fh", require("telescope.builtin").git_commits, { noremap = true })
    vim.keymap.set("n", ",fc", require("telescope.builtin").git_bcommits, { noremap = true })
    vim.keymap.set("n", ",fb", require("telescope.builtin").git_branches, { noremap = true })

    -- Todo Picker
    vim.keymap.set("n", "<leader>fd", ":TodoTelescope<CR>", { noremap = true, silent = true })

    -- Project Picker
    vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", { noremap = true, silent = true })

    -- =============== OPTIONS ===============
    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#3c3836", fg = "orange" })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "#3c3836", fg = "red" })
  end,
}
