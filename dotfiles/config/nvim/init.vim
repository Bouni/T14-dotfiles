" decide wether we use vim or neovim
if has('nvim')
    let $VIMHOME = '~/.config/nvim'
els
    let $VIMHOME = '~/.vim'
endif

" set the plugvim path
let $PLUGVIM = expand($VIMHOME . '/autoload/plug.vim')

" If vim-plug is not installed, do so and install all listed plugins
" That allows us to deploy this .vimrc on a target system and have vim setup
" automagicaly within seconds
if empty(glob($PLUGVIM))
  silent !curl -fLo $PLUGVIM --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" List of Plugins
call plug#begin($VIMHOME . '/plugged')
Plug 'airblade/vim-gitgutter'
" Caddyfile Highliting
Plug 'isobit/vim-caddyfile'
" Commenter Plugin
Plug 'preservim/nerdcommenter'
" Colorizer, displays colors for hex values and names
Plug 'norcalli/nvim-colorizer.lua'
" Dev Icons
Plug 'ryanoasis/vim-devicons'
" Go Plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Color scheme
Plug 'sheerun/vim-wombat-scheme'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
" A collection of themes for vim-airline 
Plug 'vim-airline/vim-airline-themes'
" Vim sugar for the UNIX shell commands that need it the most.
Plug 'tpope/vim-eunuch'
" Text alignment
Plug 'godlygeek/tabular'
" Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'plasticboy/vim-markdown'
" The uncompromising Python code formatter
Plug 'psf/black'
" Vim plugin to sort python imports
Plug 'fisadev/vim-isort'
" Python Completion
Plug 'davidhalter/jedi-vim'
" Prettier Plugin
Plug 'prettier/vim-prettier'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" ==============================================================================
" Global & misc
" ==============================================================================

" map leader to space                                                                              
let mapleader=" "                                                                                  

" set my default printer for hardcopy
set pdev=Samsung_M2070

set tabstop=4
set shiftwidth=4
set softtabstop=0 " 4
set scrolloff=8
set smarttab
set expandtab
set number
set nowrap
set nobackup
set nowritebackup
set noswapfile
set nofoldenable
set matchpairs=(:),[:],{:},<:>,":",':'
set mouse=r
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set termguicolors

syntax on
silent! colorscheme wombat " srcery

nnoremap <silent> <C-left> :tabprev<CR>
nnoremap <silent> <C-right> :tabnext<CR>
nnoremap <silent> <A-left> :bprev<CR>
nnoremap <silent> <A-right> :bnext<CR>




" ==============================================================================
" Airline
" ==============================================================================
let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1



" Linters for ale plugin
let b:ale_linters = ['pyflakes', 'flake8', 'pylint']

" ==============================================================================
" git gutter 
" ==============================================================================
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ==============================================================================
" FZF 
" ==============================================================================

nnoremap <silent> <C-f> :Files<CR>

" ==============================================================================
" 
" ==============================================================================
" Clear search highlite with ESC
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Map Black to F1
map <f1> :Black<CR>

" Map Isort to F2
map <f2> :Isort<CR>

" Toggle line numbers with F4
map <f4> :set invnumber<CR>

" Enable Paste mode with F5
set pastetoggle=<f5>

" Prettify on F7
map <f7> :PrettierAsync

" indent Yaml items correctly
let g:yaml_formatter_indent_collection=1

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

lua require 'colorizer'.setup({'*'; css = { names = true }}, {names = false;rgb_fn = true;hsl_fn = true;})

" Detect Hugo Templates and set filetype
function DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
        set filetype=gohtmltmpl 
    endif
endfunction

augroup filetypedetect
    au! BufRead,BufNewFile * call DetectGoHtmlTmpl()
augroup END
