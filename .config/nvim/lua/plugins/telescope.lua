return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local actions = require("telescope.actions")

    -- =============== SETUP ===============
    require("telescope").setup({

      defaults = {
        path_display = { "truncate" },
        mappings = {
          -- insert mode mappings
          i = {
            ["<C-w>t"] = actions.select_tab,
          },

          -- normal mode mappings
          n = {
            ["<C-s>"] = actions.select_horizontal,
            ["dd"] = actions.delete_buffer,
          },
        },
        cache_picker = { num_pickers = -1 },
      },
    })

    -- =============== LOAD EXTENSIONS ===============
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("bookmarks")

    -- =============== MAPPINGS ===============
    -- File Pickers
    vim.keymap.set(
      "n",
      "<leader>ff",
      require("telescope.builtin").find_files,
      { noremap = true, desc = "[telescope] Find files" }
    )
    vim.keymap.set(
      "n",
      "<leader>fg",
      require("telescope.builtin").live_grep,
      { noremap = true, desc = "[telescope] Live grep" }
    )
    vim.keymap.set(
      "n",
      "<leader>fG",
      require("telescope.builtin").grep_string,
      { noremap = true, desc = "[telescope] Live grep word under cursor" }
    )

    -- Vim Pickers
    vim.keymap.set(
      "n",
      "<leader>fr",
      require("telescope.builtin").oldfiles,
      { noremap = true, desc = "[telescope] Previously opened files" }
    )
    vim.keymap.set(
      "n",
      "<leader>fh",
      require("telescope.builtin").help_tags,
      { noremap = true, desc = "[telescope] Help files" }
    )
    vim.keymap.set(
      "n",
      "<leader>f/",
      require("telescope.builtin").search_history,
      { noremap = true, desc = "[telescope] Search history" }
    )
    vim.keymap.set(
      "n",
      "<leader>f:",
      require("telescope.builtin").command_history,
      { noremap = true, desc = "[telescope] Command history" }
    )
    vim.keymap.set(
      "n",
      '<leader>f"',
      require("telescope.builtin").registers,
      { noremap = true, desc = "[telescope] Registers" }
    )
    vim.keymap.set(
      "n",
      "<leader>f;",
      require("telescope.builtin").commands,
      { noremap = true, desc = "[telescope] Commands" }
    )
    vim.keymap.set(
      "n",
      "<leader>fk",
      require("telescope.builtin").keymaps,
      { noremap = true, desc = "[telescope] Keymaps" }
    )
    vim.keymap.set(
      "n",
      "<leader>fc",
      require("telescope.builtin").colorscheme,
      { noremap = true, desc = "[telescope] Colorschemes" }
    )
    vim.keymap.set(
      "n",
      "<leader>fl",
      require("telescope.builtin").reloader,
      { noremap = true, desc = "[telescope] Reload lua modules" }
    )
    vim.keymap.set(
      "n",
      "<leader>f`",
      require("telescope.builtin").marks,
      { noremap = true, desc = "[telescope] Marks" }
    )
    vim.keymap.set(
      "n",
      "<leader>fm",
      require("telescope.builtin").man_pages,
      { noremap = true, desc = "[telescope] Man pages" }
    )
    vim.keymap.set(
      "n",
      "<leader>ft",
      require("telescope.builtin").treesitter,
      { noremap = true, desc = "[telescope] Treesitter" }
    )
    vim.keymap.set(
      "n",
      "<leader>fb",
      require("telescope.builtin").buffers,
      { noremap = true, desc = "[telescope] Buffers" }
    )
    vim.keymap.set(
      "n",
      "<leader>fq",
      require("telescope.builtin").quickfix,
      { noremap = true, desc = "[telescope] Quickfix" }
    )
    vim.keymap.set(
      "n",
      "<leader>fQ",
      require("telescope.builtin").quickfixhistory,
      { noremap = true, desc = "[telescope] Quickfixhistory" }
    )
    vim.keymap.set(
      "n",
      "<leader>fj",
      require("telescope.builtin").jumplist,
      { noremap = true, desc = "[telescope] Jump List" }
    )
    vim.keymap.set(
      "n",
      "<leader>fv",
      require("telescope.builtin").vim_options,
      { noremap = true, desc = "[telescope] Vim Options" }
    )
    vim.keymap.set(
      "n",
      "<leader>fa",
      require("telescope.builtin").autocommands,
      { noremap = true, desc = "[telescope] Autocommands" }
    )
    vim.keymap.set(
      "n",
      "<leader>fH",
      require("telescope.builtin").highlights,
      { noremap = true, desc = "[telescope] Highlights" }
    )
    vim.keymap.set(
      "n",
      "<leader>fi",
      require("telescope.builtin").current_buffer_fuzzy_find,
      { noremap = true, desc = "[telescope] Inside Buffer fuzzy find" }
    )
    vim.keymap.set(
      "n",
      "<leader>f.",
      require("telescope.builtin").resume,
      { noremap = true, desc = "[telescope] Last used picker" }
    )
    vim.keymap.set(
      "n",
      "<leader>f,",
      require("telescope.builtin").pickers,
      { noremap = true, desc = "[telescope] Recently used pickers" }
    )

    -- Git Pickers
    vim.keymap.set(
      "n",
      ",ff",
      require("telescope.builtin").git_status,
      { noremap = true, desc = "[telescope] Git show changed/new files" }
    )
    vim.keymap.set(
      "n",
      ",fa",
      require("telescope.builtin").git_commits,
      { noremap = true, desc = "[telescope] Git checkout all commits" }
    )
    vim.keymap.set(
      "n",
      ",fc",
      require("telescope.builtin").git_bcommits,
      { noremap = true, desc = "[telescope] Git checkout cur buffer commits" }
    )
    vim.keymap.set(
      "n",
      ",fb",
      require("telescope.builtin").git_branches,
      { noremap = true, desc = "[telescope] Git checkout branches" }
    )
    vim.keymap.set(
      "n",
      ",fs",
      require("telescope.builtin").git_stash,
      { noremap = true, desc = "[telescope] Git stashes" }
    )

    -- Todo Picker
    vim.keymap.set(
      "n",
      "<leader>fd",
      ":TodoTelescope<CR>",
      { noremap = true, silent = true, desc = "[telescope] Todos" }
    )

    -- Bookmark Picker
    vim.keymap.set(
      "n",
      "<leader>fB",
      ":Telescope bookmarks<CR>",
      { noremap = true, silent = true, desc = "[telescope] Bookmarks" }
    )

    -- Custom Pickers
    local nvim_config_picker = function()
      require("telescope.builtin").find_files({
        prompt_title = "Neovim Config",
        workspace = "nvim",
      })
    end
    local awesome_config_picker = function()
      require("telescope.builtin").find_files({
        prompt_title = "Awesome Config",
        cwd = "~/.config/awesome/",
      })
    end
    local code_find_files = function()
      require("telescope.builtin").find_files({
        prompt_title = "Code",
        cwd = "/home/david/code",
      })
    end
    local code_live_grep = function()
      require("telescope.builtin").live_grep({
        prompt_title = "Code",
        cwd = "/home/david/code",
      })
    end
    Dotfiles_find_files = function()
      local dotfiles = require("utils").get_dotfiles()

      require("telescope.builtin").find_files({
        prompt_title = "Dotfiles",
        search_dirs = dotfiles,
      })
    end
    local dotfiles_live_grep = function()
      local dotfiles = require("utils").get_dotfiles()

      require("telescope.builtin").live_grep({
        prompt_title = "Dotfiles Live Grep",
        search_dirs = dotfiles,
      })
    end
    local nextcloud_find_files = function()
      require("telescope.builtin").find_files({
        prompt_title = "Nextcloud",
        cwd = "/home/david/Nextcloud",
      })
    end
    local nextcloud_live_grep = function()
      require("telescope.builtin").live_grep({
        prompt_title = "Nextcloud",
        cwd = "/home/david/Nextcloud",
      })
    end

    vim.keymap.set("n", "<leader>fn", nvim_config_picker, { noremap = true, desc = "[telescope] Nvim config files" })
    vim.keymap.set(
      "n",
      "<leader>fA",
      awesome_config_picker,
      { noremap = true, desc = "[telescope] Awesome config files" }
    )
    vim.keymap.set("n", "<leader>f1", Dotfiles_find_files, { noremap = true, desc = "[telescope] Dotfiles" })
    vim.keymap.set("n", "<leader>f2", dotfiles_live_grep, { noremap = true, desc = "[telescope] Dofiles live grep" })
    vim.keymap.set("n", "<leader>f3", code_find_files, { noremap = true, desc = "[telescope] Code" })
    vim.keymap.set("n", "<leader>f#", code_live_grep, { noremap = true, desc = "[telescope] Code live grep" })
    vim.keymap.set("n", "<leader>f4", nextcloud_find_files, { noremap = true, desc = "[telescope] Nextcloud" })
    vim.keymap.set("n", "<leader>f$", nextcloud_live_grep, { noremap = true, desc = "[telescope] Nextcloud live grep" })

    -- =============== AUTOCOMMANDS ===============
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      callback = function()
        if vim.o.background == "dark" then
          vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#414559", fg = "#ef9f76" })
          vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "#414559", fg = "#e78284" })
        end
      end,
      desc = "Disable mini-indentscope for several filetypes",
    })
  end,
}
