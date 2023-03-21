return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/schemastore.nvim" },
  config = function()
    local u = require("utils")

    -- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lsp_con = require("lspconfig")
    local on_attach_external_formatter = function(client, bufnr)
      require("plugins.lsp.mappings")(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end
    local on_attach = function(client, bufnr)
      require("plugins.lsp.mappings")(client, bufnr)
    end

    -- =============== LSP SERVERS ===============
    -- *************** HTML SERVER ***************
    lsp_con.html.setup({
      capabilities = capabilities,
      on_attach = on_attach_external_formatter,
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
        on_attach = on_attach_external_formatter,
      })
    end

    -- *************** JSON SERVER ***************
    -- set the the filetype of tsconfig.json to jsonc (json with comments)
    vim.api.nvim_create_autocmd("BufRead", { command = "setlocal filetype=jsonc", pattern = { "tsconfig.json" } })

    lsp_con.jsonls.setup({
      capabilities = capabilities,
      on_attach = on_attach_external_formatter,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- *************** LUA SERVER ***************
    lsp_con.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach_external_formatter,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use", "awesome", "naughty", "screen", "client", "root", "mouse" },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- *************** LATEX SERVER ***************
    lsp_con.texlab.setup({
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })

    -- *************** BASH SERVER ***************
    lsp_con.bashls.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        require("plugins.lsp.mappings")(client, bufnr)
      end,
    })

    -- *************** DOCKER SERVER ***************
    lsp_con.sqlls.setup({
      on_attach = on_attach_external_formatter,
    })

    -- *************** SQL SERVER ***************
    require("lspconfig").sqlls.setup({
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    })

    -- *************** YAML SERVER ***************
    require("lspconfig").yamlls.setup({
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
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
