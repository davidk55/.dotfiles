return {
  "ahmedkhalf/project.nvim",
  -- dir = "/home/david/Code/Git/BuildingRepos/project.nvim",
  config = function()
    -- =============== SETUP ===============
    require("project_nvim").setup({
      patterns = { "package.json", "pom.xml", ".git" },
      silent_chdir = true, -- deactivate to debug
      ignore_bare = true,
    })
  end,
}
