-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_con = require"lspconfig"
local on_attach = require"plugins.lsp.lsp-mappings"

-- *************** HTML SERVER ***************
lsp_con.html.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- *************** CSS SERVER ***************
lsp_con.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- *************** JAVASCRIPT/TYPESCRIPT SERVER ***************
lsp_con.tsserver.setup{
  on_attach = on_attach
}

-- *************** JSON SERVER ***************
lsp_con.jsonls.setup{
  on_attach = on_attach
}


-- *************** LUA SERVER ***************
lsp_con.sumneko_lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" }
      },
      telemetry = {
        enable = false,
      },
    }
  },
  on_attach = on_attach
}

-- *************** LATEX SERVER ***************
lsp_con.texlab.setup{
  on_attach = on_attach
}

-- *************** JAVA SERVER ***************
-- lsp_con.jdtls.setup{
--   on_attach = on_attach
-- }

-- *************** BASH SERVER ***************
lsp_con.bashls.setup{
  on_attach = on_attach
}
