return {
  "davidk55/react-extract.nvim",
  ft = { "javascriptreact", "typescriptreact" },
  config = function()
    -- =============== SETUP ===============
    require("react-extract").setup({
      ts_template_before = "function [COMPONENT_NAME]([PROPERTIES]) {\n\n[INDENT]return (\n",
      ts_template_after = "[INDENT]);\n}\n\n\nexport default [COMPONENT_NAME];",
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      { "v" },
      "<Leader>re",
      require("react-extract").extract_to_new_file,
      { noremap = true, desc = "[react-extract] Extract to new file" }
    )
    vim.keymap.set(
      { "v" },
      "<Leader>rc",
      require("react-extract").extract_to_current_file,
      { noremap = true, desc = "[react-extract] Extract to current file" }
    )
  end,
}
