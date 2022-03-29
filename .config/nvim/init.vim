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
set termguicolors
let mapleader = " "


" *************************** PLUGINS ******************************
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/morhetz/gruvbox'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'https://github.com/tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Required for nvim tree
"Plug 'kyazdani42/nvim-web-devicons'
"Plug 'kyazdani42/nvim-tree.lua'

Plug 'mbbill/undotree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" git related plugins
source $HOME/.config/nvim/vim/plugins/git.vim

" plugins for java
source $HOME/.config/nvim/vim/plugins/specific_filetype/java.vim

" plugins for latex
source $HOME/.config/nvim/vim/plugins/specific_filetype/latex.vim

call plug#end()


" *************************** ENABLE FILETYPE PLUGIN ******************************
filetype plugin on

" *************************** COLORSCHEME ******************************
colorscheme gruvbox

" *************************** MOVEMENT ******************************
" Moving in completion
cnoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "<C-j>"
cnoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "<C-k>"

" Configure Sneak
let g:sneak#label = 1
let g:sneak#s_next = 1
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;
let g:sneak#prompt = '🔎 '

" Configure Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" *************************** DELETING ******************************
" Deleting into black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" *************************** DARK/LIGHT TOGGLE ******************************
let s:lightmode = 0
function! ToggleLightMode()
    if s:lightmode
        set background=dark
        let s:lightmode = 0
    else
        set background=light
        let s:lightmode = 1
    endif
endfunction
nnoremap <leader>0 :call ToggleLightMode()<cr>

" *************************** TREES ******************************
nnoremap <leader>u :UndotreeToggle<CR>

"lua <<EOF
"require'nvim-tree'.setup {
"  disable_netrw = false,
"  hijack_netrw = false,
"}
"EOF
nnoremap <leader>e :NvimTreeToggle<CR>

" *************************** GIT ******************************
" Make gitgutter work on my dotfiles (bare repo)
let g:gitgutter_git_args='--git-dir=$HOME/.dotfiles --work-tree=$HOME'

let g:gitgutter_map_keys = 0
nmap <leader>g> <Plug>(GitGutterNextHunk)
nmap <leader>g< <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gf :GitGutterFold<CR>

" *************************** ULTISNIPS ******************************
let g:UltiSnipsEditSplit = "verical"
let g:UltiSnipsJumpForwardTrigger = "<leader>l"
let g:UltiSnipsJumpBackwardTrigger = "<leader>h"
let g:UltiSnipsExpandTrigger = "<nop>"


" *************************** COC ******************************
source $HOME/.config/nvim/vim/coc/settings.vim

" *************************** LATEX ******************************
let g:vimtex_view_method = 'zathura'

" *************************** WINDOWS ******************************
" Split Windows
nmap <leader>s :split<Return><C-w>w
nmap <leader>v :vsplit<Return><C-w>w

" Move between Windows
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

" Move Windows around
nmap <leader>H <C-w>H
nmap <leader>J <C-w>J
nmap <leader>K <C-w>K
nmap <leader>L <C-w>L
nmap <leader>n <C-w>w
nmap <leader>N <C-w>W

" Resize Windows
nmap <leader>< <C-w><
nmap <leader>> <C-w>>
nmap <leader>= <C-w>=
nmap <leader>- <C-w>-
nmap <leader>+ <C-w>+

" Quit Window
nmap <leader>q <C-w>q

" *************************** TABS ******************************
nmap <leader>t :tabedit<Return>

" *************************** EXPLORER ******************************
nmap <leader>e :Explore<Return>

" *************************** WRITING/CLOSING ******************************
nmap <leader>w :w
nmap <leader>! :q!<Return>

" *************************** COPY/PASTE ******************************
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>p "+p
vmap <leader>p "+p
