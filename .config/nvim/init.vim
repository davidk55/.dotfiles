" Tabs
set softtabstop=4 " used when you want a different tab length in blank lines
set tabstop=4 " length of the tab
set shiftwidth=4 " should be the same as tabstop
set expandtab " tabs are now spaces
set smartindent

" Line Numbers
set relativenumber
set number

" Searching
set hlsearch
set incsearch

" Look
set signcolumn=yes " add an extra column at the beginning
set colorcolumn=80 " adds an red bar at the 80th column
set cmdheight=2 " more space for displaying messages

" Misc.
set noerrorbells
set nowrap " makes that text does not wrap to a new line when its to long
set scrolloff=8 " scrolls when 8 lines before the end of the screen
set updatetime=50 " gives it a little longer updatetime, but no noticable delay
" set paste
set hidden " makes that you can leave a buffer without saving
set ruler " show current cursor position on the bottom right


call plug#begin('~/.vim/plugins')
Plug 'https://github.com/morhetz/gruvbox'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'mbbill/undotree'

"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
call plug#end()

"function! statuslinegit()
	"let l:branchname = gitbranch()
	"return strlen(l:branchname) > 0?'  '.l:branchname.'  ':''
"endfunction

"set statusline=
"set statusline+=%{StatuslineGit()}

colorscheme gruvbox
filetype plugin on

let mapleader = " "

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <C-n> :NvimTreeToggle<CR>
set termguicolors

nnoremap <leader>u :UndotreeToggle<CR>
