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
        python = { "isort", "black" },
        javascript = { "prettierd", "rustywind" },
        javascriptreact = { "prettierd", "rustywind" },
        typescript = { "prettierd", "rustywind" },
        typescriptreact = { "prettierd", "rustywind" },
        vue = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        html = { "prettierd", "rustywind" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
        java = { "google-java-format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shellharden" },
        tex = { "latexindent" },
        bib = { "bibtex-tidy" },
        nix = { "alejandra", "nixpkgs_fmt" },
        sql = { "sqlfluff" },
        yaml = { "yamlfmt" },
        php = { "php_cs_fixer" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        -- ["*"] = { "codespell" },
      },
      -- Formatters configurations
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        prettierd = {
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
        return { timeout_ms = 2000, lsp_fallback = true }
      end,
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<leader>lf", function()
      if vim.b.disable_autoformat then
        vim.b.disable_autoformat = false
        vim.notify("[conform] Enable Formatting", vim.log.levels.INFO)
      else
        vim.b.disable_autoformat = true
        vim.notify("[conform] Disable Formatting", vim.log.levels.INFO)
      end
    end, { noremap = true, silent = true, desc = "[conform] Toggle formatting" })

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
