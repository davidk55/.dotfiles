local u = require("utils") -- function to load the configuration file

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local navic = require("nvim-navic")

local lsp_con = require("lspconfig")
local on_attach = function(client, bufnr)
  require("plugins.lsp.lsp-mappings")(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
end

-- *************** HTML SERVER ***************
lsp_con.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- *************** CSS SERVER ***************
local function checkProjectUsesTailwind()
  local lines = u.get_lines(vim.loop.cwd() .. "/package.json")
  for _, v in pairs(lines) do
    if string.match(v, "tailwindcss") then
      return true
    end
  end
  return false
end

if checkProjectUsesTailwind() then
  lsp_con.tailwindcss.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
else
  lsp_con.cssls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require("plugins.lsp.lsp-mappings")(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      navic.attach(client, bufnr)
    end,
  })
end

-- *************** JAVASCRIPT/TYPESCRIPT SERVER ***************
lsp_con.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require("plugins.lsp.lsp-mappings")(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    navic.attach(client, bufnr)
  end,
})

-- *************** JSON SERVER ***************
lsp_con.jsonls.setup({
  on_attach = on_attach,
})

-- *************** LUA SERVER ***************
lsp_con.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client, bufnr)
    require("plugins.lsp.lsp-mappings")(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    navic.attach(client, bufnr)
  end,
})

-- *************** LATEX SERVER ***************
lsp_con.texlab.setup({
  on_attach = on_attach,
})

-- *************** BASH SERVER ***************
lsp_con.bashls.setup({
  on_attach = on_attach,
})
