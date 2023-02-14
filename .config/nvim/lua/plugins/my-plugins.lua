return {
  {
    "davidk55/testplugin.nvim",
    dev = true, -- load from local path: ~/code/projects/nvim
    enabled = true,
    config = function()
      -- mapping to reload the plugin
      vim.keymap.set("n", "<leader><leader>r", function()
        local plugin = require("lazy.core.config").plugins["testplugin.nvim"]
        require("lazy.core.loader").reload(plugin)
      end, {})
    end,
  },
}
