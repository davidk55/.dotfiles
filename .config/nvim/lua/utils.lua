local M = {}

-- used to load from the plugin specific file in the setup directory
function M.load_setup(plugin_name)
  return string.format('require("plugins.setups.%s")', plugin_name)
end

return M
