-- *************************** TABS ******************************
vim.opt.softtabstop = 2 -- used when you want a different tab length in blank lines
vim.opt.tabstop = 2 -- length of the tab
vim.opt.shiftwidth = 2 -- should be the same as tabstop
vim.opt.expandtab = true -- tabs are now spaces
vim.opt.smartindent = true

-- *************************** LINE NUMBERS ******************************
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

-- *************************** SEARCHING ******************************
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- *************************** LOOK ******************************
vim.opt.signcolumn = "yes" -- add an extra column at the beginning
vim.opt.colorcolumn = "80" -- adds an bar at the 80th column

-- *************************** SPLITTING ******************************
vim.opt.splitright = true
vim.opt.splitbelow = true

-- *************************** FOLDING ******************************
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:\uf47c,foldsep: ,foldclose:\uf460]]

-- *************************** COLORTHEME ******************************
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- *************************** MISC ******************************
vim.opt.errorbells = false
vim.opt.wrap = false -- makes that text does not wrap to a new line when its to long
vim.opt.scrolloff = 10 -- scrolls when 8 lines before the end of the screen
vim.opt.updatetime = 50 -- gives it a little longer updatetime, but no noticeable delay
vim.opt.hidden = true -- makes that you can leave a buffer without saving
vim.opt.ruler = true -- show current cursor position on the bottom right
vim.opt.cmdheight = 0 -- set the cmdheight to 0
vim.opt.mouse = "a" -- enable mouse in all modes
vim.opt.encoding = "utf-8"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- *************************** NEOVIDE ******************************
vim.o.guifont = "Fira Code:h11" -- text below applies for VimScript
vim.g.neovide_scale_factor = 1.0

-- *************************** LOREM IPSUM ******************************
vim.cmd(
  'let @l = "    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."'
)
