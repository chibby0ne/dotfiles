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

" pathogen (easier installation of plugins
"call pathogen#infect()
"call pathogen#helptags()

""""""""""""
" vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"required by vundle
Plugin 'gmarik/Vundle.vim'

" Ultisnip
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
"  Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Solarized
Plugin 'altercation/vim-colors-solarized'
"Ctrl-p
Plugin 'kien/ctrlp.vim'
"Syntastic
Plugin 'scrooloose/syntastic'
"Tagbar
Plugin 'majutsushi/tagbar'
"Vim-airline
Plugin 'bling/vim-airline'
" Vim-fugitive
Plugin 'tpope/vim-fugitive'
" Vim-commentary
Plugin 'tpope/vim-commentary'
" You Complete Me
Plugin 'Valloric/YouCompleteMe'

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""
" end Vundle plugin

" Remap keys used for you complete me (ycm) cycling through options 
let g:ycm_key_list_select_completion = [ '<C-k>', '<Enter>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-l>', '<Up>']

"When this option is set to 1, YCM will auto-close the preview window 
"after the user accepts the offered completion string. If there is no 
"preview window triggered because there is no preview string in completeopt, 
"this option is irrelevant. See the g:ycm_add_preview_to_completeopt option 
"for more details.
let g:ycm_autoclose_preview_window_after_completion = 1

" Semantic Completer for STL containers and std library objetcs and functions
" (needed to add paths for gcc includes
" using command: "echo | clang -std=c++11 -stdlib=libc++ -v -E -x c++ -"
" the headers path found in in the section "#include <...> search starts here"
" appending them with a "-isystem," before each path, and 
" adding them to "flags" variable in  ".ycm_extra_conf.py"
" seen here: "https://stackoverflow.com/questions/15266194/my-youcompleteme-vim-plugin-doesnt-support-stl"
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'


"When this option is set to 1 YCM will ask once per .ycm_extra_conf.py file if
"it is safe to be loaded. This is to prevent execution of malicious code from
"a .ycm_extra_conf.py file you didn't write.
" To avoid asking confirmation for a .ycm_extra_conf.py
let g:ycm_confirm_extra_conf = 0

" From "https://github.com/Valloric/YouCompleteMe#options"
" If you're using YCM's identifier completer in C-family languages but cannot
" use the clang-based semantic completer for those languages and want to use
" the GCC Syntastic checkers, unset this option.
let g:ycm_show_diagnostics_ui = 0


" for opening ctrlp in MRU file mode
let g:ctrlp_cmd = 'CtrlPMRU'
" for letting ctrlp show hidden files
let g:ctrlp_show_hidden = 1


" recommendation for solarized
se t_Co=16
"se t_Co=256

colorscheme solarized
"colorscheme gotham256

"" THIS CODE WAS ADDED BY SOLARIZED_GNOME_TERMINAL script ""
"" FOR CORRECT BEHAVIOUR DO NOT MODIFY ""

" getting time and setting dark or light theme
let sunrise="06:31"
let sunset="18:43"

let hour=strftime("%H:%M")
if sunrise <= hour && hour < sunset
    set background=light
else
    set background=dark
endif

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
nmap <c-v> :vsp<CR>


" mapping of next tab page
" nmap <C-m> gt

" remap <Leader>
let mapleader="'"

" mapping closing buffer
nmap <Leader>c :bd<CR>

" latex syntastic
let g:syntastic_tex_checkers=['lacheck']

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

"vim-airline
set laststatus=2

" syntastic remommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" highlight current line number gutter
" hi clear CursorLine
" augroup CLClear
"         autocmd! colorscheme * hi clear CursorLine
" augroup END

" hi CursorLineNR cterm=bold
augroup CLNRSet
         autocmd! colorscheme * hi CursorLineNR cterm=bold
augroup END

set cursorline
set relativenumber

"set tab space = 4
set tabstop=4
set shiftwidth=4
set expandtab
set sts=4

" ctrlp plugin
" set runtimepath^=~/.vim/bundle/ctrlp.vim

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
        autocmd FileType text setlocal spell textwidth=78

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
        au BufRead,BufNewFile *.md set spell textwidth=78
        au BufRead,BufNewFile *.md set commentstring=\<!--%s--\>
        
        "Xetex
        autocmd BufRead,BufNewFile *.xtx set filetype=tex

        "java
        autocmd bufnewfile *.java so ~/Templates/java_template.txt
        autocmd bufnewfile *.java exe "1," . 7 . "g/file:.*/s//file: " .expand("%")
        autocmd bufnewfile *.java exe "1," . 9 . "g/public class .*/s//public class " .expand("%:t:r") "{"
        autocmd bufnewfile *.java exe "1," . 7 . "g/date:.*/s//date: " .strftime("%Y-%m-%d")
        autocmd Bufwritepre,filewritepre *.java execute "normal ma"
        autocmd bufwritepost,filewritepost *.java execute "normal `a"

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


" For coursera algoriths course
let g:syntastic_java_javac_classpath=".:~/algs4/algs4.jar:~/algs4/stdlib.jar"
