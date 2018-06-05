" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"set line number
set number

" Set utf8 as standard enconding and en_US as the standard language
set encoding=utf8

" Case sentitivity for search
set ignorecase

" Turn on incremental search
set incsearch

" keep 50 lines of command line history
set history=50
"
" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

"set paste key
set pastetoggle=<F2>


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" vim-colors-solarized
Plug 'altercation/vim-colors-solarized'

" vim-comementary: provides shortcuts and keybindings for
" commenting/uncommenting code
Plug 'tpope/vim-commentary'

" ale (Asynchronous Lint Engine)
Plug 'w0rp/ale'

" vim-airline
Plug 'vim-airline/vim-airline'

" vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" deoplete-flow
Plug 'steelsojka/deoplete-flow'

" deoplete-jedi (for python)
Plug 'zchee/deoplete-jedi'

" deoplete-go (for go)
Plug 'zchee/deoplete-go', { 'do': 'make' }

" deoplete-clang (for c/c++/objective-c/objective-c++)
Plug 'zchee/deoplete-clang'

" deoplete-rust (for rust)
Plug 'sebastianmarkow/deoplete-rust'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""
" ALE Config
""""""""""""""""""""""""""""""""
" AFter this is configured :ALEFix will try and fix your JS code with eslint
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default
let g:ale_fix_on_save  = 1

" Ale completion where possible
let g:ale_completion_enabled = 1

" Shortcut for :ALEFix
nmap <leader>d <Plug>(ale_fix)

""""""""""""""""""""""""""""""""""
" vim-airline config
""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""
" vim-airline-themes config
""""""""""""""""""""""""""""""""""
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

""""""""""""""""""""""""""""""""""
" vim-colors-solarized
""""""""""""""""""""""""""""""""""
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

""""""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vectical>"

""""""""""""""""""""""""""""""""""
" deoplete
""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""
" deoplete-flow
""""""""""""""""""""""""""""""""""
let g:deoplete#sources#flow#flow_bin = 'flow' 
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

if g:flow_path != 'flow not found'
  let g:deoplete#sources#flow#flow_bin = g:flow_path
endif


""""""""""""""""""""""""""""""""""
" deoplete-jedi (for python)
""""""""""""""""""""""""""""""""""
let g:deoplete#sources#jedi#show_docstring = 1

""""""""""""""""""""""""""""""""""
" deoplete-rust (for rust)
""""""""""""""""""""""""""""""""""
let g:deoplete#sources#rust#racer_binary = '~/.cargo/bin/racer'
let g:deoplete#sources#rust#racer_source_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'

""""""""""""""""""""""""""""""""""
" deoplete-clang (for C/C++/Objective-C/Objective-C++)
""""""""""""""""""""""""""""""""""
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header =  '/usr/include/clang/'

"""""""""""""""""""""""""""""""""""
" mapping h, j, k, l to j, k, l. ;
"""""""""""""""""""""""""""""""""""
" left
nnoremap j h
" down
nnoremap k j
" up
nnoremap l k
" right
nnoremap ; l

" visual mode
" left
xnoremap j h
" down
xnoremap k j
" up
xnoremap l k
" right
xnoremap ; l

"""""""""""""""""""""""""""""""""""
" Navigating tags
"""""""""""""""""""""""""""""""""""
" Pop back to the previous tag location
noremap L <c-t>

"""""""""""""""""""""""""""""""""""
" mapping windows switching to use new map of home keys
"""""""""""""""""""""""""""""""""""
" left
noremap <c-w>j <c-w>h
" down
noremap <c-w>k <c-w>j
" up
noremap <c-w>l <c-w>k
" right
noremap <c-w>; <c-w>l

" map of save(write) to C-s
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<CR>

" map of quit to C-q
nmap <c-q> :q<cr>
imap <c-q> <Esc>:q<cr>

" mapping of Esc
imap jk <Esc>
cmap jk <c-u><bs>
vmap jk <Esc>

" mapping of Tagbar
nmap <c-m> :Tagbar<CR>

" mapping of h to nothing
nmap h <nop>

" mapping of vertical and horizontal split (just like ctrlp)
nmap <c-x> :sp<CR>
nmap <c-s> :vsp<CR>


" mapping of next tab page
" nmap <C-m> gt

" remap <Leader>
let mapleader="'"

" mapping closing buffer
nmap <Leader>c :bd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" Spell checker
"""""""""""""""""""""""""""""""""""""""""""""""
" Pressing 'en/es/de will toggle and untoggle spell checking
map <leader>en :setlocal spell!<cr>

map <leader>es :setlocal spell! spelllang=es<cr>

map <leader>de :setlocal spell! spelllang=de<cr>

" Shortcuts using <leader>
map <leader>n ]s
map <leader>p [s
map <leader>a zg
map <leader>q z=

" folding to automatic and also be able to create new folds
augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" highlight current line number gutter
hi clear CursorLine
augroup CLClear
        autocmd! colorscheme * hi clear CursorLine
augroup END

hi CursorLineNR cterm=bold
augroup CLNRSet
         autocmd! colorscheme * hi CursorLineNR cterm=bold
augroup END

set cursorline
" " set relativenumber

"set tab space = 4
set tabstop=4
set shiftwidth=4
set expandtab
set sts=4

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal spell textwidth=78 fo+=t

        " For all text files set 'textwidth' to 78 characters.

        " source .vimrc any time a file is saved so the background color changes if
        " it becomes day/night
        " autocmd bufwritepost * source ~/.vimrc

        "Vim arduino syntax highlighting
        "filetype has to coincide with in *.snippet in snippet folder
        au BufRead,BufNewFile *.pde, *.ino set filetype=arduino
        au BufRead,BufNewFile *.ino set filetype=arduino

        " for Markdown
        au BufRead,BufNewFile *.md set filetype=markdown
        au BufRead,BufNewFile *.md set spell textwidth=78 fo+=t
        au BufRead,BufNewFile *.md set commentstring=\<!--%s--\>

        "Xetex
        autocmd BufRead,BufNewFile *.xtx set filetype=tex

        " for vhdl
        autocmd bufnewfile *.vhd so ~/Templates/VHDL_template.txt
        autocmd bufnewfile *.vhd exe "1," . 7 . "g/file:.*/s//file: " .expand("%")
        autocmd bufnewfile *.vhd exe "1," . 7 . "g/date:.*/s//date: " .strftime("%Y-%m-%d")
        autocmd Bufwritepre,filewritepre *.vhd execute "normal ma"
        autocmd bufwritepost,filewritepost *.vhd execute "normal `a"

        " for makefile
        autocmd bufnewfile Makefile so ~/Templates/Makefile_template.txt

        " for CMakeList
        autocmd bufnewfile CMakeLists.txt so ~/Templates/CMakeLists_template.txt
        autocmd BufRead,BufNewFile *.cpp,*.c,*.h, set textwidth=80 fo+=t

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END


else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
