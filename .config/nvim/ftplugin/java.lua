-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- ********************** CONFIGURATION **********************
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    "/usr/lib/jvm/java-11-openjdk/bin/java", -- or "/path/to/java11_or_newer/bin/java"
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar", "/home/david/.local/share/Java/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    "-configuration", "/home/david/.local/share/Java/eclipse.jdt.ls/config_linux/",
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    "-data", "/home/david/.cache/jdtls/" .. project_name,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({".git", "pom.xml", "gradlew"}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  -- settings = {
  --   java = {
  --   }
  -- },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don"t plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  -- init_options = {
  --   bundles = {}
  -- },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)

local navic = require("nvim-navic")

config['on_attach'] = function(client, bufnr)
  navic.attach(client, bufnr)
end

-- ********************** OPTIONS **********************
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- ********************** MAPPINGS **********************
local ns = { noremap = true, silent = true}
local nsb = { noremap = true, silent = true, buffer = 0}
local e = { expr = true}
-- Diagnostics
vim.keymap.set("n", "d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", ns)
vim.keymap.set("n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble<CR>", ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble loclist<CR>", ns)
vim.keymap.set("n", "<leader>dq", "<cmd>Trouble quickfix<CR>", ns)

-- GENERAL
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nsb)
vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<CR>", nsb)
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", ns)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", nsb)
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", nsb)
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", nsb)
vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", nsb)
vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", nsb)
vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nsb)
vim.keymap.set("n", "<leader>D", "<cmd>Trouble lsp_type_definitions<CR>", nsb)
vim.keymap.set("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", nsb)
vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", nsb)
vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", nsb)
vim.keymap.set("n", "<leader>oi", "<cmd>lua require(\"jdtls\").organize_imports()<CR>", nsb)
vim.keymap.set("n", "<leader>ev", "<cmd>lua require(\"jdtls\").extract_variable()<CR>", nsb)
vim.keymap.set("v", "<leader>ev", "<esc><cmd>lua require(\"jdtls\").extract_variable(true)<CR>", nsb)
vim.keymap.set("n", "<leader>ec", "<cmd>lua require(\"jdtls\").extract_constant()<CR>", nsb)
vim.keymap.set("v", "<leader>ec", "<esc><cmd>lua require(\"jdtls\").extract_constant(true)<CR>", nsb)
vim.keymap.set("v", "<leader>em", "<esc><cmd>lua require(\"jdtls\").extract_method(true)<CR>", nsb)

-- CUSTOM
vim.keymap.set("i", "<A-;>", "<esc>A;<CR>", nsb)
vim.keymap.set("n", "<A-;>", function()
  local line = vim.api.nvim_get_current_line()
  if string.sub(line, #line, #line) == ";" then
    return "$i"
  else
    return "A;<esc>^"
  end
end, e)
vim.keymap.set("n", "<A-'>", function()
  local line = vim.api.nvim_get_current_line()
  if string.find(line, "System") ~= nil then
    return "^df(<esc>$hx^"
  elseif string.sub(line, #line, #line) == ";" then
    return "ISystem.out.println(<esc>$i)<esc>^"
  else
    return "ISystem.out.println(<esc>$a);<esc>^"
  end
end, e)
