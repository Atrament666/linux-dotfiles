" Atramentovo ultimatni .vimrc
"

"plugins
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar' "okno s metodami a proměnnými
Plug 'tpope/vim-fugitive'
Plug 'peterhoeg/vim-qml'
Plug 'tpope/vim-vinegar' "lepší procházení souborů
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'cpiger/neodebug'
Plug 'yggdroot/indentline'
Plug 'bfrg/vim-cpp-modern'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'aklt/plantuml-syntax'
Plug 'junegunn/goyo.vim' "distraction free writing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'preservim/nerdtree'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'stevearc/oil.nvim'
call plug#end()

set nocompatible
set mouse=a
filetype plugin indent on 
filetype plugin on
filetype detect

"set invpaste
syntax enable
set history=1000
set tw=0
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent 
set backspace=2 "nastaví backaspace na 'normální' chování
set wildmenu
let g:tex_flavor='pdflatex %'
let g:Tex_Folding=0
let g:indentLine_setConceal=0
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set ruler
set scrolloff=999
set completeopt-=preview
set clipboard=unnamedplus
set noshowmode
set encoding=utf-8

"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/qt4
"set tags+=~/.vim/tags/clementine

"nastavení barev
hi Pmenu guibg=steelblue3 guifg=bg ctermfg=7 ctermbg=4 cterm=bold
hi PmenuSel guibg=fg guifg=bg gui=bold ctermfg=4 ctermbg=7 cterm=bold
hi Folded ctermfg=DarkGrey ctermbg=Black
hi Comment ctermfg=LightBlue
hi TabLineSel ctermbg=LightBlue ctermfg=Yellow
hi TabLine ctermfg=DarkGrey ctermfg=Yellow
hi LineNr ctermbg=darkgrey ctermfg=white
hi CursorLine cterm=NONE ctermbg=darkgrey

set cursorline
set splitbelow

map  :tabnew 
map <C-Right> :tabnext  
map <C-Left> :tabprevious

imap  :tabnew 
imap <C-Right> :tabnext  
imap <C-Left> :tabprevious 

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
map <F3> :NERDTreeToggle
map <F15> :NERDTreeFind
map <tab> <Right>
map <S-Tab> <Left>
let g:UltiSnipsExpandTrigger='<tab>'
map <f16> :Buffers

if has("autocmd")
	  autocmd BufReadPost *
	      \ if line("'\"") > 1 && line("'\"") <= line("$") |
	      \   exe "normal! g`\"" |
	      \ endif
endif

au BufRead /tmp/neomutt-* set tw=0
au BufRead /tmp/neomutt-* set spell
au BufRead /tmp/neomutt-* set spelllang=cs

"air-line configuration
let g:airline_powerline_fonts = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"spelling
"set spelllang=cs
" pgdown next typo
"nnoremap <PageDown> ]s 
" pgup prev typo
"nnoremap <PageUp> [s
" home add to dict and jump to next
"nnoremap <Home> zg]s
" end list of options
"nnoremap <End> z=


function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

function! ToggleHeaderSource()
    let file_path = expand("%")
    let file_name = expand("%<")
    let extension = split(file_path, '\.')[-1]
    if extension == "c" || extension == "cpp"
        let header_file = join([file_name, ".h"], "")
        if filereadable(header_file)
            execute "e" header_file
        else
            echo join(["No header file", header_file], "")
        endif
    endif
    if extension == "h"
        echo "Toggling to source"
        let source_file = join([file_name, ".cpp"], "")
        if filereadable(source_file)
            execute "e" source_file
        else
            echo join(["No source file", source_file], ""):
        endif

    endif
endfunction

lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
}


require('nvim-treesitter.configs').setup {
    parser_install_dir = "~/.treesitter/"
}

require("oil").setup()
EOF

