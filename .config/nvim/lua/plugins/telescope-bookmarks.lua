return {
  "dhruvmanila/telescope-bookmarks.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "https://github.com/tyru/open-browser.vim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        bookmarks = {
          -- selected_browser = "firefox",
          -- profile_name = "default-release",
          selected_browser = "buku",
          url_open_plugin = "open_browser",
        },
      },
    })
  end,
}
