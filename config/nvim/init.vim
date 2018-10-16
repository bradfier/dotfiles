let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3.6'

call plug#begin('~/.local/share/nvim/plugged')

Plug 'autozimu/LanguageClient-neovim', { 
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Plug 'Shougo/deoplete.nvim',  { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'ervandew/supertab'

Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'

Plug 'davidhalter/jedi-vim'

" Colours
Plug 'zcodes/vim-colors-basic'
Plug 'zacanger/angr.vim'
Plug 'arcticicestudio/nord-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1

" Tmux
Plug 'edkolev/tmuxline.vim'

" Org stuff
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'

call plug#end()

colorscheme angr

set expandtab
set shiftwidth=4
set tabstop=4
set ruler
"set number

set hidden

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rls'],
            \ 'python': ['pyls']
            \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5
"set signcolumn=yes

let mapleader=","
let maplocalleader="\\"

autocmd FileType rs,rust,python nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
autocmd FileType rs,rust,python nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
autocmd FileType rs,rust,python nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
autocmd FileType rs,rust set colorcolumn=80

" Bindings
map <C-n> :NERDTreeToggle<CR>

nmap ; :Buffers<CR>
nmap <Leader>t :FZF<CR>
nmap <Leader>r :Tags<CR>

nnoremap <CR> :nohl<CR>
