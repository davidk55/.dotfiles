" Tabs
set softtabstop=2 " used when you want a different tab length in blank lines
set tabstop=2 " length of the tab
set shiftwidth=2 " should be the same as tabstop
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
set encoding=utf-8
let mapleader = " "


call plug#begin('~/.vim/plugged')
Plug 'https://github.com/morhetz/gruvbox'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'https://github.com/tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Required for nvim tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

"Plug 'mbbill/undotree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" git related plugins
source $HOME/.config/nvim/vim/plugins/git.vim

" plugins for java
source $HOME/.config/nvim/vim/plugins/specific_filetype/java.vim

" plugins for latex
source $HOME/.config/nvim/vim/plugins/specific_filetype/latex.vim

call plug#end()


" Configure Sneak
let g:sneak#label = 1
let g:sneak#s_next = 1
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;
let g:sneak#prompt = '🔎 '


" Configure Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

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
