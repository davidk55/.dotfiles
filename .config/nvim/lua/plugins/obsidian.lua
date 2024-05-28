local ns = { noremap = true, silent = true }

return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- =============== SETUP ===============
    require("obsidian").setup({
      workspaces = {
        {
          name = "MainVault",
          path = "~/Nextcloud/Main/Obsidian/MainVault",
        },
        {
          name = "PenAndPaperVault",
          path = "~/Nextcloud/Main/Obsidian/PenAndPaperVault",
        },
        {
          name = "CommunityVault",
          path = "~/Nextcloud/Community/CommunityVault",
        },
      },
      daily_notes = {
        folder = "Journaling/Daily Notes/",
        date_format = "%Y-%m-%d",
        template = "Daily Notes Template",
      },
      completion = {
        min_chars = 1,
      },
      note_id_func = function(title)
        return title
      end,
      disable_frontmatter = true,
      templates = {
        subdir = "Templates/Neovim",
      },
      follow_url_func = function(url)
        vim.notify(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,
      ui = {
        enable = true,
        update_debounce = 200,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#ef9f76" },
          ObsidianDone = { bold = true, fg = "#99d1db" },
          ObsidianRightArrow = { bold = true, fg = "#ef9f76" },
          ObsidianTilde = { bold = true, fg = "#e78284" },
          ObsidianBullet = { bold = true, fg = "#99d1db" },
          ObsidianRefText = { underline = true, fg = "#ca9ee6" },
          ObsidianExtLinkIcon = { fg = "#ca9ee6" },
          ObsidianTag = { italic = true, fg = "#99d1db" },
          ObsidianBlockID = { italic = true, fg = "#99d1db" },
          ObsidianHighlightText = { bg = "#8caaee" },
        },
      },
      attachments = {
        img_folder = "Attachments/Images",
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      "n",
      "<leader>fo",
      ":ObsidianQuickSwitch<CR>",
      { noremap = true, silent = true, desc = "[obsidian] Search for file" }
    )
    vim.keymap.set(
      "n",
      "<leader>fO",
      ":ObsidianSearch<CR>",
      { noremap = true, silent = true, desc = "[obsidian] Search for text inside the file" }
    )
  end,
}
