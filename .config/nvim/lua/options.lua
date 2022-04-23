-- *************************** TABS ******************************
vim.opt.softtabstop = 2       -- used when you want a different tab length in blank lines
vim.opt.tabstop = 2           -- length of the tab
vim.opt.shiftwidth = 2        -- should be the same as tabstop
vim.opt.expandtab = true      -- tabs are now spaces
vim.opt.smartindent = true

-- *************************** LINE NUMBERS ******************************
vim.opt.relativenumber = true
vim.opt.number = true

-- *************************** SEARCHING ******************************
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- *************************** LOOK ******************************
vim.opt.signcolumn = 'yes'    -- add an extra column at the beginning
vim.opt.colorcolumn = '80'    -- adds an bar at the 80th column
vim.opt.cmdheight = 2         -- more space for displaying messages

-- *************************** SPLITTING ******************************
vim.opt.splitright = true
vim.opt.splitbelow = true

-- *************************** FOLDING ******************************
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'

-- *************************** COLORTHEME ******************************
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- *************************** MISC ******************************
vim.opt.errorbells = false
vim.opt.wrap = false          -- makes that text does not wrap to a new line when its to long
vim.opt.scrolloff = 10        -- scrolls when 8 lines before the end of the screen
vim.opt.updatetime = 50       -- gives it a little longer updatetime, but no noticable delay
vim.opt.hidden = true         -- makes that you can leave a buffer without saving
vim.opt.ruler = true          -- show current cursor position on the bottom right
vim.opt.encoding = 'utf-8'
vim.g.mapleader = ' '
