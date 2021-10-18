" =========================================================================
"                           bouni's NVIM config
"
" :so % to reload current config!
"
" Sources:
"  - https://www.youtube.com/watch?v=wzrZPcwh-bE
"  - https://vimcolorschemes.com/
"  - http://neovimcraft.com/
"
" =========================================================================


" ================ Auto Install Plug Plugin manager =======================
" set the plugvim path
let $VIMHOME = '~/.config/nvim'
let $PLUGVIM = expand($VIMHOME . '/autoload/plug.vim')
" If vim-plug is not installed, do so and install all listed plugins
" That allows us to deploy this init.vim on a target system and have nvim setup
" automagicaly within seconds
if empty(glob($PLUGVIM))
  silent !curl -fLo $PLUGVIM --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" =========================== Plugins =====================================
call plug#begin($VIMHOME . '/plugged')

" Colorscheme
Plug 'sainnhe/sonokai'
" Statusline 
Plug 'itchyny/lightline.vim'
" Pair completion for {}, '', etc.
Plug 'jiangmiao/auto-pairs'
" Icons for use in plugin Icons for use in plugins 
Plug 'ryanoasis/vim-devicons'
" Telescope 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Colorizer for for hexcodes
Plug 'norcalli/nvim-colorizer.lua'
" Nercommenter
" https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'
" COC completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Git Gutter
Plug 'airblade/vim-gitgutter'
" Rainbow brackets 
Plug 'frazrepo/vim-rainbow'
" Which key
Plug 'liuchengxu/vim-which-key'
" Vim Fugitive
Plug 'tpope/vim-fugitive'
" PSF Black
Plug 'psf/black'
" Docker Compose Syntax Highlight
Plug 'nlknguyen/vim-docker-compose-syntax'

call plug#end()

" ============================ Various settings ===========================
set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
if (has("termguicolors"))
    set termguicolors
endif
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set colorcolumn=80

let g:mapleader = " "  
let g:maplocalleader = ","

" =========================== configurations ===============================

" ---- Color scheme ----
colorscheme sonokai
let g:sonokai_style = 'atlantis'

" ---- Lightline ----
let g:lightline = {
    \ 'colorscheme': 'sonokai', 
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
	\ 'component_function': {
	\   'readonly': 'LightlineReadonly',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
	\ }
\ }

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" ---- Telescope ----
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ---- Colorizer ----
lua require 'colorizer'.setup {
    \ 'css';
    \ 'javascript';
    \ html = {
    \   mode = 'foreground';
    \}
\}

" ---- Nerdcommenter ----
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" ---- COC ----
let g:coc_global_extensions = ['coc-python', 'coc-css', 'coc-pyright']

" ---- Git Gutter ----
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ---- Vim Rainbow ----
let g:rainbow_active = 1

" ---- WhichKey ----
let g:maplocalleader = ","
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>

" ---- Fugitive ----
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Git<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

" ---- Black ----
nnoremap <space>b :Black<CR>
