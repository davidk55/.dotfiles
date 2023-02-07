local M = {}

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

local function is_substring(str, substr)
  return string.find(str, substr, 1, true) ~= nil
end

function M.get_full_filename(search_input, path)
  local files = vim.fn.split(vim.fn.glob(path .. "/*"), "\n")
  for _, file in ipairs(files) do
    if is_substring(file, search_input) then
      return file
    end
  end
end

return M
