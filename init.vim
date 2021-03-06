
" Authors: Otto Lote
" Description: Personal nvim configuration file (work in progress)
" License: GPLv3
" Note: Loosely based on http://vim.wikia.com/wiki/Example_vimrc

" This file is organized with folds using foldmethod=marker in vim.
" Reading this file is a lot more pleasant with folding.

" TODO:
" - Personal note: Move all colors to this file instead of .Xresources 

" Plugins {{{
      call plug#begin('~/.vim/plugged')

"   Deoplete {{{

"     Load {{{

        if has('nvim')
          Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        else
          Plug 'Shougo/deoplete.nvim'
          Plug 'roxma/nvim-yarp'
          Plug 'roxma/vim-hug-neovim-rpc'
        endif

        Plug 'zchee/deoplete-jedi'

"     }}}
"     Config {{{

        let g:deoplete#enable_at_startup = 1

"     }}}
"     Mappings {{{

        " deoplete tab-complete
        inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"     }}}

"   }}}
"   Neomake {{{

"     Load {{{

        Plug 'neomake/neomake'

"     }}}

"   }}}
"   Neoformat {{{

"     Load {{{

        Plug 'sbdchd/neoformat'

"     }}}
"     Config {{{


"     }}}

"   }}}
"   Neoterm {{{

      Plug 'kassio/neoterm'

"     Config {{{

        " ,tt to run command bound with :Tmap
        let g:neoterm_automap_keys = ',tt'

        " set size of the created terminal split
        let g:neoterm_size = "15"

"     }}}
"     Mappings {{{

        "" hide/close terminal
        "nnoremap <silent> ,th :call neoterm#close()<cr>
        "" clear terminal
        "nnoremap <silent> ,tl :call neoterm#clear()<cr>
        "" kills the current job (send a <c-c>)
        "nnoremap <silent> ,tc :call neoterm#kill()<cr>
        "
        "" toggle the neoterm terminal
        "nnoremap <silent> ,to :Ttoggle<cr>

"     }}}

"   }}}
"   NERDTree {{{

      Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }

      " Config
      " Map ctrl+n to toggle nerdtree
      map <C-n> :NERDTreeToggle<CR>

"   }}}
"   Solarized colorscheme {{{

      Plug 'altercation/vim-colors-solarized'

      " Use the option "colorscheme solarized" to apply this plugin
      
"   }}}
"   Spiffy Fold {{{

      Plug 'atimholt/spiffy_foldtext'

      " Config
      if has('multi_byte')
          let g:SpiffyFoldtext_format = "%c{═}  %<%f{═}╡ %4n lines ╞═%l{╤═}"
      else
          let g:SpiffyFoldtext_format = "%c{=}  %<%f{═}| %4n lines |=%l{/=}"
      endif

"   }}}
"
      call plug#end()
"   Postconfig {{{
"     Neomake {{{
"       Config {{{

          " When writing a buffer (no delay).
          call neomake#configure#automake('w')
          " When writing a buffer (no delay), and on normal mode changes (after 750ms).
          call neomake#configure#automake('nw', 750)
          " When reading a buffer (after 1s), and when writing (no delay).
          call neomake#configure#automake('rw', 1000)
          " Full config: when writing or reading a buffer, and on changes in insert and
          " normal mode (after 1s; no delay when writing).
          call neomake#configure#automake('nrwi', 500)

"       }}}
"     }}}
"   }}}

" }}}
" Search {{{
   
    " Highlight searches (use <C-L> to temporarily turn off highlighting; see the
    " mapping of <C-L> below)
    set hlsearch

    " Use case insensitive search, except when using capital letters
    set ignorecase
    set smartcase

" }}}
" Coloring {{{

    " Syntax highlighting/coloring
    syntax enable

    " Dark works nicely with solarized theme
    set background=dark

    " Use 'altercation/vim-colors-solarized' (plugin)
    colorscheme solarized

    " Fold color and formatting
    highlight Folded term=bold cterm=NONE ctermfg=Gray

" }}}
" Folding {{{

    " Fold on markers by default
    set foldmethod=syntax

    " Start unfolded
    set foldlevelstart=20

    " Fold init.vim nicely using foldmarkers
    autocmd BufRead init.vim setlocal foldmethod=marker
    autocmd BufRead init.vim setlocal foldlevel=0

" }}}
" Display {{{

    " Relative numbers are displayed instead of line numbers
    set relativenumber

    " Show line numbers 
    " When relative numbers are set, show line number for current line
    set number

    " Show line number and position of marker in bottom right corner
    set ruler

" }}}
" Indentation {{{

    " Attempt to determine the type of a file based on its name and possibly its
    " contents. Use this to allow intelligent auto-indenting for each filetype,
    " and for plugins that are filetype specific.
    filetype indent plugin on

    " Use 2 spaces instead of tab
    set shiftwidth=2
    set softtabstop=2
    set expandtab

    "" Use hard tabs but display them as 2 characters wide
    " set shiftwidth=2
    " set tabstop=2

    " Allow backspacing over autoindent, line breaks and start of insert action
    set backspace=indent,eol,start

    " When opening a new line and no filetype-specific indenting is enabled, keep
    " the same indent as the line you're currently on. Useful for READMEs, etc.
    set autoindent

    " Stop certain movements from always going to the first character of a line.
    " While this behaviour deviates from that of Vi, it does what most users
    " coming from other editors would expect.
    set nostartofline

" }}}
" Key Mapping {{{
    
    " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
    " which is the default
    map Y y$

    " Map <C-L> (redraw screen) to also turn off search highlighting until the
    " next search
    nnoremap <C-L> :nohl<CR><C-L>

" }}}
" Security {{{

  " TODO:
  "  - disable swap-files and backup for certain files (such as when editing files with GNU pass)

" }}}
