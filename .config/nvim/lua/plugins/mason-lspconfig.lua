return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "b0o/schemastore.nvim",
  },
  config = function()
    -- =============== SETUP ===============
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "dockerls",
        "docker_compose_language_service",
        "emmet_language_server",
        "gopls",
        "gradle_ls",
        "graphql",
        "html",
        "intelephense",
        "jsonls",
        "lemminx",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "sqls",
        "tailwindcss",
        "texlab",
        "yamlls",
      },
    })

    -- =============== LSP SERVERS ==============={

    --------------------------------------------------
    -- Capabilities
    --------------------------------------------------

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    --------------------------------------------------
    -- Attach
    --------------------------------------------------

    local on_attach = function(client, bufnr)
      print("LSP ATTACHED:", client.name)
      require("plugins.lsp.mappings")(client, bufnr)
    end

    local on_attach_external_formatter = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end

    --------------------------------------------------
    -- Default config
    --------------------------------------------------

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    --------------------------------------------------
    -- Filetype fixes
    --------------------------------------------------

    vim.filetype.add({
      filename = {
        ["tsconfig.json"] = "jsonc",
        ["launch.json"] = "jsonc",
        ["docker-compose.yml"] = "yaml.docker-compose",
      },
    })

    --------------------------------------------------
    -- Server specific configs
    --------------------------------------------------

    vim.lsp.config("lua_ls", {
      on_attach = on_attach_external_formatter,
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
              "use",
              "awesome",
              "naughty",
              "screen",
              "client",
              "root",
              "mouse",
            },
          },
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("emmet_language_server", {
      on_attach = on_attach_external_formatter,
      filetypes = {
        "javascriptreact",
        "typescriptreact",
        "typescript",
        "javascript",
        "astro",
        "css",
        "html",
        "less",
        "php",
        "sass",
        "scss",
        "svelte",
        "vue",
      },
    })

    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          classAttributes = {
            "class",
            "className",
            "class:list",
            "classList",
            "ngClass",
          },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
          emmetCompletions = true,
        },
      },
    })

    vim.lsp.config("cssls", {
      on_attach = on_attach_external_formatter,
      settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
      },
    })

    vim.lsp.config("jsonls", {
      on_attach = on_attach_external_formatter,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })

    vim.lsp.config("bashls", {
      on_attach = on_attach_external_formatter,
    })

    vim.lsp.config("docker_compose_language_service", {
      settings = {
        telemetry = { enableTelemetry = false },
      },
    })

    vim.lsp.config("intelephense", {
      settings = {
        diagnostics = { enable = true },
        intelephense = {
          stubs = {
            "apache",
            "bcmath",
            "bz2",
            "calendar",
            "Core",
            "ctype",
            "curl",
            "date",
            "dba",
            "dom",
            "enchant",
            "FFI",
            "fileinfo",
            "filter",
            "fpm",
            "ftp",
            "gd",
            "gettext",
            "gmp",
            "hash",
            "iconv",
            "imap",
            "intl",
            "json",
            "ldap",
            "libxml",
            "mbstring",
            "mysqli",
            "mysql",
            "openssl",
            "pcntl",
            "pcre",
            "PDO",
            "pdo_mysql",
            "pdo_pgsql",
            "pdo_sqlite",
            "pgsql",
            "Phar",
            "posix",
            "Reflection",
            "session",
            "SimpleXML",
            "snmp",
            "soap",
            "sockets",
            "sodium",
            "SPL",
            "sqlite3",
            "standard",
            "superglobals",
            "tokenizer",
            "xml",
            "xmlreader",
            "xmlwriter",
            "xsl",
            "zip",
            "zlib",
            "wordpress",
            "woocommerce",
            "acf-pro",
            "acf-stubs",
            "wordpress-globals",
            "wp-cli",
            "genesis",
            "polylang",
            "sbi",
          },
        },
      },
    })

    vim.lsp.config("jdtls", {
      handlers = {
        ["$/progress"] = function(_, _, _) end,
      },
    })
  end,
}
