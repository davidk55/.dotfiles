return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/schemastore.nvim" },
  config = function()
    local u = require("utils")

    -- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lsp_con = require("lspconfig")
    local on_attach = function(client, bufnr)
      require("plugins.lsp.mappings")(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end

    -- =============== LSP SERVERS ===============
    -- *************** HTML SERVER ***************
    lsp_con.html.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require("plugins.lsp.mappings")(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
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
          require("plugins.lsp.mappings")(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })
    end

    -- *************** JSON SERVER ***************
    vim.api.nvim_create_autocmd("BufRead", { command = "setlocal filetype=jsonc", pattern = { "tsconfig.json" } })

    lsp_con.jsonls.setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
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
        require("plugins.lsp.mappings")(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
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

    -- =============== OPTIONS ===============
    -- set signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- use circle instead of square
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
    })
  end,
}
