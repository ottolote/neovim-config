" URL: github url coming after inital commit
" Authors: Otto Lote (loosely based on http://vim.wikia.com/wiki/Example_vimrc)
" Description: Personal nvim configuration file (WIP), feel free to use as you wish
" License: kopimi
" Plugins {{{
"
" Installed plugins {{{
" vim-plug
call plug#begin('~/.vim/plugged')

" Deoplete-clang{{{
"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'

"}}}
" Solarized colorscheme {{{
"
" You need the option "colorscheme solarized" to apply this plugin
Plug 'altercation/vim-colors-solarized'
"}}}
" Neoterm {{{

Plug 'kassio/neoterm'

" }}}
" vim-plug usage examples {{{
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" }}}

" Add plugins to &runtimepath
call plug#end()
"}}}
" Plug config {{{
"
" Deoplete-clang {{{
"
" Deoplete general
let g:deoplete#enable_at_startup = 1

" Deoplete-clang specific, see
" https://github.com/zchee/deoplete-clang#available-settings for more info
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/3.9.1/include/'
" }}}
" Neoterm {{{

" ,tt to run command bound with :Tmap
let g:neoterm_automap_keys = ',tt'

" set size of the created terminal split
let g:neoterm_size = "15"

" }}}
"
" }}}
"
"}}}
" Security {{{
"
" TODO:
"  - disable swap-files for certain files (like when used with GNU pass)

" Make sure no sensitive info is stored in backups when editing sensitive
" files
set nobackup

"}}}
" Usability {{{
"
" Search {{{
" 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" }}}
" Folding {{{
"
" Fold on markers by default
set foldmethod=marker
" }}}
"
" }}}
" Indentation options {{{
"
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
" set shiftwidth=2
" set tabstop=2
"
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

"}}}
" Mappings {{{
"
" General useful mappings {{{

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
"}}}
" Custom mappings {{{
" Compile all latex files in the folder
nnoremap <F3> :!latex *.tex<Enter><Enter>

" Git convenience mappings (a bit shit)
nnoremap <F4> :!git commit -am "$(date) "; git pull<Enter>
nnoremap <F2> :!git push<Enter><Enter>

" Reload file from disk
nnoremap <F5> :edit<Enter>

" Location list for completions etc.
nnoremap <F10> :ll<Enter>
"}}}
" Plugin mappings {{{
"
" Deoplete {{{
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"}}}
" Neoterm {{{

" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" toggle the neoterm terminal
nnoremap <silent> ,to :Ttoggle<cr>

" }}}
"
" }}}

"}}}
" Colors {{{

syntax enable

" dark works nicely with solarized theme
set background=dark

" Must have 'altercation/vim-colors-solarized' as plugin
colorscheme solarized

"}}}
