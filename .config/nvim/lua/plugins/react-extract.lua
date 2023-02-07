return {
  "davidk55/react-extract.nvim",
  -- "napmn/react-extract.nvim",
  ft = { "javascriptreact", "typescriptreact" },
  config = function()
    -- =============== SETUP ===============
    require("react-extract").setup({
      ts_template_before = "function [COMPONENT_NAME]([PROPERTIES]) {\n\n[INDENT]return (\n",
      ts_template_after = "[INDENT]);\n}\n\n\nexport default [COMPONENT_NAME];",
    })
    -- =============== MAPPINGS ===============
    vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
    vim.keymap.set({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file)
  end,
}
