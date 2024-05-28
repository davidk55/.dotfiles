return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  config = function()
    -- =============== SETUP ===============
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
      },
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      "n",
      "<leader>ts",
      ":Neotest summary<CR>",
      { noremap = true, silent = true, desc = "[neotest] Show summary" }
    )
    vim.keymap.set("n", "<leader>tr", ":Neotest run<CR>", { noremap = true, silent = true, desc = "[neotest] Run" })
    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { noremap = true, desc = "[neotest] Debug current file with dap" })
  end,
}
