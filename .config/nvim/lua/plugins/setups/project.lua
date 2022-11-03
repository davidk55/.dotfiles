require("project_nvim").setup({
  patterns = { ".git", "package.json", "pom.xml" },
  -- deactivate to debug
  silent_chdir = true,
})
