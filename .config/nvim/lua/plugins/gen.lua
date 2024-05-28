return {
  "David-Kunz/gen.nvim",
  config = function()
    -- =============== SETUP ===============
    require("gen").setup({
      model = "codellama",
      host = "localhost",
      port = "11434",
      display_mode = "float",
      show_prompt = false,
      show_model = false,
      quit_map = "q",
      no_auto_close = false, -- Never closes the window automatically.
      init = function() end,
      -- Function to initialize Ollama
      command = function(options)
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      debug = false,
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      { "n", "v" },
      "<leader><leader>a",
      ":Gen<CR>",
      { noremap = true, silent = true, desc = "[gen] Run prompt/Execute" }
    )
  end,
}
