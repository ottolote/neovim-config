" URL: https://github.com/ottolote/neovim-config
" Authors: Otto Lote
" Description: Personal nvim configuration file (work in progress)
" License: GPLv3
" Note: Loosely based on http://vim.wikia.com/wiki/Example_vimrc

" This file is organized with folds using foldmethod=marker in vim.

" Plugins {{{

"   __vim-plug header {{{

      call plug#begin('~/.vim/plugged')

"   }}}
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
"   Git {{{

      Plug 'tpope/vim-fugitive'
      Plug 'lewis6991/gitsigns.nvim'

"   }}}
"   Language Server {{{

      Plug 'neovim/nvim-lspconfig'
      
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

        " hide/close terminal
        nnoremap <silent> ,th :call neoterm#close()<cr>
        " clear terminal
        nnoremap <silent> ,tl :call neoterm#clear()<cr>
        " kills the current job (send a <c-c>)
        nnoremap <silent> ,tc :call neoterm#kill()<cr>
        
        " toggle the neoterm terminal
        nnoremap <silent> ,to :Ttoggle<cr>

"     }}}

"   }}}
"   NERDTree {{{

      Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }

      " Config
      " Map ctrl+n to toggle nerdtree
      map <C-n> :NERDTreeToggle<CR>

"   }}}
"   Colorschemes {{{

      Plug 'rafi/awesome-vim-colorschemes'
      
"   }}}
"   GPT {{{

      Plug 'robitx/gp.nvim'

"   }}}
"   Markdown {{{

      Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

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
"   __vim-plug-footer{{{

      call plug#end()

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

    syntax enable

    set background=dark

    colorscheme minimalist

" }}}
" Completion {{{
"  
      " Set up nvim-lspconfig
      autocmd VimEnter * lua require'lspconfig'.pyright.setup{}
"
" }}}
" Folding {{{

    " Fold on markers by default
    set foldmethod=syntax

    " Start unfolded
    set foldlevelstart=20

    " Fold init.vim and lua/config.lua nicely using foldmarkers
    autocmd BufRead init.vim setlocal foldmethod=marker
    autocmd BufRead init.vim setlocal foldlevel=0
    autocmd BufRead config.lua setlocal foldmethod=marker
    autocmd BufRead config.lua setlocal foldlevel=0

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
      
lua require('config')
