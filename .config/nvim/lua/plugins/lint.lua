local ns = { noremap = true, silent = true }

local function enable_linting()
  vim.diagnostic.enable(0)
  require("lint").try_lint()
  require("lint").try_lint("typos")
end

local function disable_linting()
  local ft = vim.filetype.match({ buf = 0 })
  if ft == nil then
    return
  end
  require("lint").linters_by_ft[ft] = {}
  vim.diagnostic.disable(0)
end

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

    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<leader>ll", function()
      if vim.b.is_linting_disabled then
        vim.b.is_linting_disabled = false
        enable_linting()
        vim.notify("[nvim-lint] Enable Linting", vim.log.levels.INFO)
      else
        vim.b.is_linting_disabled = true
        disable_linting()
        vim.notify("[nvim-lint] Disable Linting", vim.log.levels.INFO)
      end
    end, { desc = "[nvim-lint] Toggle linting" })

    -- =============== AUTOCOMMANDS ===============
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      callback = function()
        if vim.b.is_linting_disabled then
          return
        end
        enable_linting()
      end,
    })
    vim.api.nvim_create_autocmd(
      "BufRead",
      { command = "setlocal filetype=env.sh", pattern = { ".env" }, desc = "Make env files also be of the sh filetype" }
    )
  end,
}
