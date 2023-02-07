local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local u = require("utils")

-- =============== CONFIG ===============
local config = {
  cmd = {
    "/home/david/.sdkman/candidates/java/17.0.5-tem/bin/java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:/home/david/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar",

    "-jar",
    u.get_full_filename("org.eclipse.equinox.launcher_", "/usr/lib/jvm/eclipse.jdt.ls/plugins"),

    "-configuration",
    "/home/david/.local/share/Java/eclipse.jdt.ls/config_linux/",

    "-data",
    "/home/david/.cache/jdtls/" .. project_name,
  },

  root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "gradlew" }),
}

require("jdtls").start_or_attach(config)

config.handlers["language/status"] = function() end

-- =============== OPTIONS ===============
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.bo.formatoptions = "jnqlr"

-- =============== MAPPINGS ===============
local ns = { noremap = true, silent = true }
local nsb = { noremap = true, silent = true, buffer = 0 }
local e = { expr = true }

-- Diagnostics
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", ns)
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble<CR>", ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble loclist<CR>", ns)

-- GENERAL
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", nsb)
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", nsb)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", nsb)
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", nsb)
vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", nsb)
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", nsb)

-- JAVA SPECIFIC
vim.keymap.set("n", "<leader>oi", '<cmd>lua require("jdtls").organize_imports()<CR>', nsb)
vim.keymap.set("n", "<leader>ev", '<cmd>lua require("jdtls").extract_variable()<CR>', nsb)
vim.keymap.set("v", "<leader>ev", '<esc><cmd>lua require("jdtls").extract_variable(true)<CR>', nsb)
vim.keymap.set("n", "<leader>ec", '<cmd>lua require("jdtls").extract_constant()<CR>', nsb)
vim.keymap.set("v", "<leader>ec", '<esc><cmd>lua require("jdtls").extract_constant(true)<CR>', nsb)
vim.keymap.set("v", "<leader>em", '<esc><cmd>lua require("jdtls").extract_method(true)<CR>', nsb)

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
