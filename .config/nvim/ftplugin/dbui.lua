-- =============== OPTIONS ===============
vim.opt.cmdheight = 2

-- =============== MAPPINGS ===============
vim.keymap.set(
  "n",
  "<leader>jj",
  ":JavaRunnerToggleLogs<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Toggle runner console" }
)
vim.keymap.set(
  "n",
  "<leader>jr",
  ":JavaRunnerRunMain<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run main" }
)
vim.keymap.set(
  "n",
  "<leader>jt",
  ":JavaTestRunCurrentMethod<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run current test method" }
)
vim.keymap.set(
  "n",
  "<leader>jT",
  ":JavaTestRunCurrentClass<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run current test class" }
)
vim.keymap.set(
  "n",
  "<leader>jl",
  ":JavaTestViewLastReport<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] View last test results" }
)
