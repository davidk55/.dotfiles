return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    -- =============== SETUP ===============
    require("mason-tool-installer").setup({
      ensure_installed = {
        "cmakelint",
        "gitlint",
        "htmlhint",
        "yamllint",
      },
    })
  end,
}
