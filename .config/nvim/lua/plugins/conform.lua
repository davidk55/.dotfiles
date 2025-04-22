return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    -- =============== SETUP ===============
    require("conform").setup({
      -- Formatters to load
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black", stop_after_first = true },
        javascript = { "prettier", "rustywind" },
        javascriptreact = { "prettier", "rustywind" },
        typescript = { "prettier", "rustywind" },
        typescriptreact = { "prettier", "rustywind" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier", "rustywind", stop_after_first = true },
        json = { "prettier" },
        jsonc = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        java = { "google-java-format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shellharden" },
        tex = { "latexindent" },
        bib = { "bibtex-tidy" },
        nix = { "alejandra", "nixpkgs_fmt", stop_after_first = true },
        sql = { "sqlfluff" },
        yaml = { "yamlfmt" },
        php = { "prettier", "rustywind", "php_cs_fixer" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        toml = { "taplo" },
        -- ["*"] = { "codespell" },
      },
      -- Formatters configurations
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        prettier = {
          prepend_args = { "--single-quote" },
        },
        latexindent = {
          prepend_args = { "-c", "/tmp" },
        },
        php_cs_fixer = {
          prepend_args = { "--using-cache=no" },
        },
      },
      -- Format on save
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end,
    })

    -- =============== CUSTOM COMMANDS ===============
    -- Command to disable formatting
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
      vim.notify("[conform] Disable Formatting", vim.log.levels.INFO)
    end, {
      desc = "[conform] Disable autoformat-on-save",
      bang = true,
    })
    -- Command to enable formatting
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("[conform] Enable Formatting", vim.log.levels.INFO)
    end, {
      desc = "[conform] Re-enable autoformat-on-save",
    })
  end,
}
