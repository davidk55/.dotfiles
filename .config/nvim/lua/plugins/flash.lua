return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "[flash] Run",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "[flash] Selection of near treesitter nodes",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "[flash] Run remote",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "[flash] Selection of remote treesitter nodes",
    },
  },
}
