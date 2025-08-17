syntax on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set noswapfile
set mouse=a
set number

let mapleader = " "

map J 10j
map K 10k
nmap W 5w
nmap B 5b
nmap L $
nmap H ^
omap L $
omap H ^
vmap L $h
vmap H ^

nnoremap t gt
nnoremap T gT

vnoremap <C-c> :w !wl-copy<CR><CR>

