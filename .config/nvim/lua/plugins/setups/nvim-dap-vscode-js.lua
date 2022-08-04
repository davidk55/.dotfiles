require("dap-vscode-js").setup({
  node_path = "/usr/bin/node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/david/.dap/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}/dist",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}/dist",
  }
}
  }
end
