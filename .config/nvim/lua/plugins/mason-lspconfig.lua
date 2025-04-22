return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "nvim-java/nvim-java",
    "saghen/blink.cmp",
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
        "jdtls",
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
    local lsp_con = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach_external_formatter = function(client, bufnr)
      require("plugins.lsp.mappings")(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end
    local on_attach = function(client, bufnr)
      require("plugins.lsp.mappings")(client, bufnr)
    end

    -- =============== HANDLERS ===============
    require("mason-lspconfig").setup_handlers({
      -- *************** LUA SERVER ***************
      ["lua_ls"] = function()
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
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      -- *************** EMMET SERVER ***************
      ["emmet_language_server"] = function()
        lsp_con.emmet_language_server.setup({
          capabilities = capabilities,
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
      end,
      -- *************** TAILWIND SERVER ***************
      ["tailwindcss"] = function()
        lsp_con.tailwindcss.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            tailwindCSS = {
              classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
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
      end,
      -- *************** CSS SERVER ***************
      ["cssls"] = function()
        lsp_con.cssls.setup({
          capabilities = capabilities,
          settings = {
            css = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
            scss = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
            less = { validate = true, lint = {
              unknownAtRules = "ignore",
            } },
          },
        })
      end,
      -- *************** JSON SERVER ***************
      ["jsonls"] = function()
        -- set the the filetype of tsconfig.json to jsonc (json with comments)
        vim.api.nvim_create_autocmd("BufRead", {
          command = "setlocal filetype=jsonc",
          pattern = { "tsconfig.json", "launch.json" },
          desc = "Make tsconfig.json and launch.json be of filetype jsonc",
        })
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
      end,
      -- *************** LATEX SERVER ***************
      ["texlab"] = function()
        lsp_con.texlab.setup({
          capabilities = capabilities,
        })
      end,
      -- *************** BASH SERVER ***************
      ["bashls"] = function()
        lsp_con.bashls.setup({
          capabilities = capabilities,
          on_attach = on_attach_external_formatter,
        })
      end,
      -- *************** DOCKER FILE SERVER ***************
      ["dockerls"] = function()
        lsp_con.dockerls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** DOCKER COMPOSE SERVER ***************
      ["docker_compose_language_service"] = function()
        vim.api.nvim_create_autocmd("BufRead", {
          command = "setlocal filetype=yaml.docker-compose",
          pattern = { "docker-compose.yml" },
          desc = "Make docker-compose.yml also be of type docker-compose",
        })

        lsp_con.docker_compose_language_service.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            telemetry = {
              enableTelemetry = false,
            },
          },
        })
      end,
      -- *************** SQL SERVER ***************
      ["sqls"] = function()
        lsp_con.sqlls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      -- *************** YAML SERVER ***************
      ["yamlls"] = function()
        lsp_con.sqlls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
      end,
      -- *************** PHP SERVER ***************
      ["intelephense"] = function()
        lsp_con.intelephense.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            diagnostics = {
              enable = true,
            },
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
                "efix",
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
                "meta",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "oci8",
                "odbc",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "phpunit",
                "posix",
                "pspell",
                "readline",
                "recode",
                "Reflection",
                "regex",
                "session",
                "shmop",
                "SimpleXML",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "sqlite3",
                "standard",
                "superglobals",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "yaml",
                "Zend OPcache",
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
                "lemminx",
              },
            },
          },
        })
      end,
      -- *************** C/C++ SERVER ***************
      ["clangd"] = function()
        lsp_con.clangd.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** XML SERVER ***************
      ["lemminx"] = function()
        lsp_con.lemminx.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** GRAPHQL SERVER ***************
      ["graphql"] = function()
        lsp_con.graphql.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** GRADLE SERVER ***************
      ["gradle_ls"] = function()
        lsp_con.gradle_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** CMAKE SERVER ***************
      ["cmake"] = function()
        lsp_con.cmake.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** JAVA SERVER ***************
      ["jdtls"] = function()
        lsp_con.jdtls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** PYTHON SERVER ***************
      ["pyright"] = function()
        lsp_con.pyright.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      -- *************** GO SERVER ***************
      ["gopls"] = function()
        lsp_con.gopls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
    })
  end,
}
