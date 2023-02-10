return {
  "akinsho/toggleterm.nvim",

  config = function()
    -- =============== SETUP ===============
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      size = 20,
    })

    -- =============== GLOBAL FUNCTIONS ===============
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
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", ",,g", ":lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>d", ":lua _LAZYDOCKER_TOGGLE()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>n", ":lua _NODE_TOGGLE()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>l", ":lua _LUA_TOGGLE()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>j", ":lua _JAVA_TOGGLE()<CR>", { noremap = true, silent = true })
    vim.keymap.set("t", "<A-Esc>", "<C-\\><C-n>", { noremap = true }) -- go into normal mode inside the terminal
  end,
}
