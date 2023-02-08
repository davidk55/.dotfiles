return {
  -- "ahmedkhalf/project.nvim",
  dir = "/home/david/Code/Git/BuildingRepos/project.nvim",
  config = function()
    -- =============== SETUP ===============
    require("project_nvim").setup({
      patterns = { "package.json", "pom.xml" },
      silent_chdir = true, -- deactivate to debug
    })
  end,
}
