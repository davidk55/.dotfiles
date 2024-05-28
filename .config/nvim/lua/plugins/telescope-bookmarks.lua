return {
  "dhruvmanila/telescope-bookmarks.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "https://github.com/tyru/open-browser.vim",
  },
  config = function()
    -- =============== SETUP ===============
    require("browser_bookmarks").setup({
      selected_browser = "buku",
      url_open_plugin = "open_browser",
    })
  end,
}
