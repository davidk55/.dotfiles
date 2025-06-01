return {

  "neovim/nvim-lspconfig",

  dependencies = { "b0o/schemastore.nvim" },

  config = function()
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

    -- =============== LSP SERVERS ==============={

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
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
    -- *************** EMMET SERVER ***************
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
    -- *************** TAILWIND SERVER ***************
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
    -- *************** CSS SERVER ***************
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
    -- *************** JSON SERVER ***************
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
    -- *************** LATEX SERVER ***************
    lsp_con.texlab.setup({
      capabilities = capabilities,
    })
    -- *************** BASH SERVER ***************
    lsp_con.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach_external_formatter,
    })
    -- *************** DOCKER FILE SERVER ***************
    lsp_con.dockerls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** DOCKER COMPOSE SERVER ***************
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
    -- *************** SQL SERVER ***************
    lsp_con.sqlls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- *************** YAML SERVER ***************
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
    -- *************** PHP SERVER ***************
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
    -- *************** C/C++ SERVER ***************
    lsp_con.clangd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** XML SERVER ***************
    lsp_con.lemminx.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** GRAPHQL SERVER ***************
    lsp_con.graphql.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** GRADLE SERVER ***************
    lsp_con.gradle_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** CMAKE SERVER ***************
    lsp_con.cmake.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** JAVA SERVER ***************
    lsp_con.jdtls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = {
        ["$/progress"] = function(_, _, _) end,
      },
    })
    -- *************** PYTHON SERVER ***************
    lsp_con.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- *************** GO SERVER ***************
    lsp_con.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
