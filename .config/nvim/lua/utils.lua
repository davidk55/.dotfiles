local M = {}

-- used to load from the plugin specific file in the setup directory
function M.load_setup(plugin_name)
  pcall(require, "plugins.setups." .. plugin_name)
end

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

function M.get_lines(path)
  if not file_exists(path) then
    return {}
  end
  local lines = {}
  for line in io.lines(path) do
    lines[#lines + 1] = line
  end
  return lines
end

return M
