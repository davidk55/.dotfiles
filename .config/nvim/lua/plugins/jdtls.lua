-- FIX: lsp on java files does not work
return {
  "mfussenegger/nvim-jdtls",
  config = function()
    -- =============== OPTIONS ===============
    vim.opt.bufhidden = "unload" -- to make jdtls lsp work properly
  end,
}
