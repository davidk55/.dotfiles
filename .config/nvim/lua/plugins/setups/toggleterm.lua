require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  size = 20,
  start_in_insert = true,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
local node = Terminal:new({ cmd = "node", hidden = true, direction = "float", floatopts = { "curved" } })
local lua = Terminal:new({ cmd = "lua", hidden = true, direction = "float" })
local java = Terminal:new({ cmd = "jshell", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

function _LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

function _NODE_TOGGLE()
  node:toggle()
end

function _LUA_TOGGLE()
  lua:toggle()
end

function _JAVA_TOGGLE()
  java:toggle()
end
