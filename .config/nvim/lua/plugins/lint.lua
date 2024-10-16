return {
  "mfussenegger/nvim-lint",
  config = function()
    -- =============== SETUP ===============
    -- Linters to load
    require("lint").linters_by_ft = {
      cmake = { "cmakelint" },
      gitcommit = { "gitlint" },
      html = { "htmlhint" },
      yaml = { "yamllint" },
      cpp = { "cppcheck" },
      rust = { "clippy" },
    }
    -- Linters configurations
    local yamllint = require("lint").linters.yamllint
    yamllint.args = {
      "-c",
      "/home/david/.config/yamllint/config.yml",
      "--format",
      "parsable",
      "-",
    }

    -- =============== AUTOCOMMANDS ===============
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        if vim.b.is_linting_disabled then
          return
        end
        require("utils").enable_linting()
      end,
    })
    vim.api.nvim_create_autocmd(
      "BufRead",
      { command = "setlocal filetype=env.sh", pattern = { ".env" }, desc = "Make env files also be of the sh filetype" }
    )
  end,
}
