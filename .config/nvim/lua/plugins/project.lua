return {
  "ahmedkhalf/project.nvim",
  config = function()
    -- =============== SETUP ===============
    require("project_nvim").setup({
      patterns = { ".git", "package.json", "pom.xml" },
      silent_chdir = true, -- deactivate to debug
    })
  end,
}
