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
"set pastetoggle=<F2>

if has("nvim")
  set undodir=$HOME/.config/nvim/undo " where to save undo histories
  set backupdir=$HOME/.config/nvim/backup/
  set directory=$HOME/.config/nvim/backup/
else
  set nocompatible
  set undodir=$HOME/.config/vim/undo " where to save undo histories
  set backupdir=$HOME/.config/vim/backup/
  set directory=$HOME/.config/vim/backup/
  set viminfo+=$HOME/.config/vim/viminfo
  set runtimepath+=$HOME/.config/vim
endif

set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set backup

" set termguicolors (needed for neosolarized, vim-solarized and other
" solarized themes) ONLY FOR TERMINALS THAT SUPPORT TRUE COLORS
"set termguicolors

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

" vim-javascript
Plug 'pangloss/vim-javascript'

" vim-jsx
Plug 'mxw/vim-jsx'

" vim-airline
Plug 'vim-airline/vim-airline'

" vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" deoplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" language client
" Plug 'autozimu/LanguageClient-neovim', {
"             \ 'branch': 'next',
"             \ 'do': 'bash install.sh',
"             \ }

" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-commentary
Plug 'tpope/vim-commentary'

" vim-fugitive
Plug 'tpope/vim-fugitive'

" TagBar
Plug 'majutsushi/tagbar'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Zeal for vim
Plug 'KabbAmine/zeavim.vim'

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""
" fzf plugin
""""""""""""""""""""""""""""""


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
let g:solarized_termtrans=1


""""""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""""""
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""""""
" deoplete
""""""""""""""""""""""""""""""""""
"let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""
" coc-snippets
""""""""""""""""""""""""""""""""""

" " Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

""""""""""""""""""""""""""""""""""
" coc.vim
""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Toggle coc diagnostics
nmap <C-S-P> :call CocAction('diagnosticToggle')<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Comment
autocmd FileType json syntax match Comment +\/\/.\+$+


""""""""""""""""""""""""""""""""""
" language client configuration
""""""""""""""""""""""""""""""""""
" let g:LanguageClient_serverCommands = {
"             \ 'rust': ['rustup', 'run', 'stable', 'rls'],
"             \ 'python': ['pyls'],
"             \ 'go': ['gopls'],
"             \ 'javascript': ['javascript-typescript-langserver'],
"             \ 'cpp': ['clangd'],
"             \ 'c': ['clangd'],
"             \ 'h': ['clangd'],
"             \ 'sh': ['bash-language-server', 'start'],
"             \ 'java': ['jdtls', '-data', getcwd()],
"             \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" Shows info of whatever the cursor in hovering on
" let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
" set completefunc=LanguageClient#complete
" set formatexpr=LanguageClient_textDocument_rangeFormatting()
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" Jumps to definition
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" Renames all symbols in the code
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" Can find a symbol in the code
" nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
" Calls the formatter on the source file
" nnoremap <silent> <C-f> :call LanguageClient#textDocument_formatting()<CR>
" Show all references of symb
" nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>

" Getting the debug info
" nnoremap <silent> <leader>ll :call LanguageClient#debugInfo()<CR>

" Go pls
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
" autocmd BufWritePre *.go :call LanguageClient#textDocument_codeAction_select("source.organizeImports")
" nnoremap <silent> <C-1> :call LanguageClient#textDocument_codeAction()<CR>
" autocmd BufWritePre *.go :call LanguageClient#textDocument_codeAction(["source.organizeImports"])<CR>

" let $RUST_BACKTRACE = 1
" let g:LanguageClient_loggingLevel = 'INFO'
" let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
" let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

" LanguageClient#textDocument_codeAction_select(actionName)

" let g:LanguageClient_useFloatingHover=0


"""""""""""""""""""""""""""""""""""
" Zeal for vim
"""""""""""""""""""""""""""""""""""
nmap <leader>z <Plug>Zeavim<CR>
vmap <leader>z <Plug>ZVVisSelection<CR>
nmap gz <Plug>ZVOperator<CR>
nmap <leader><leader>z <Plug>ZVKeyDocset<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""
" alias for searching visually selected text
""""""""""""""""""""""""""""""""""""""""""""""
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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
set relativenumber

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

        autocmd BufRead,BufNewFile *.yml,*.yaml,*.yml.jinja,*.yaml.jinja set shiftwidth=2 | set tabstop=2 | set filetype=yaml

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

        " for rust
        autocmd BufReadPost *.rs setlocal filetype=rust

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
