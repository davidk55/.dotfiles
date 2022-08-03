local M = {}

-- used to load from the plugin specific file in the setup directory
function M.load_setup(plugin_name)
  pcall(require, "plugins.setups." .. plugin_name)
end

return M
