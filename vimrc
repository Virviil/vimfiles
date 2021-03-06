"------------------------------------------------------------------------------
" Pathogen
"------------------------------------------------------------------------------
execute pathogen#infect()
call pathogen#helptags()

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
set nocompatible               " Turn off vi compatibility
source $VIMRUNTIME/mswin.vim   " Some basic MS keybindings
filetype plugin on             " Enable filetype plugin
filetype indent on             " Enable indent pluing

" Get cross-platform runtime and paths
let is_windows=has("win32")
if is_windows
  let vimfiles_path=$HOME. "/vimfiles/"
  let vimrc_path=$HOME . "/_vimrc"
  let terminal="cmd"
  let terminal_flag="/c"
else
  let vimfiles_path="~/.vim/"
  let vimrc_path="~/.vimrc"
  let terminal="bash"
  let terminal_flag="-c"
endif

set autoread                   " Reloads file, When it is changed outside VIM
set hidden                     " Enable handling of multiple buffers
set history=1000               " Keep a longer history of commands
runtime macros/matchit.vim     " Extended % matching

set noerrorbells               " No bells for error messages
set visualbell                 " Use visual bell instead of beeping
set vb t_vb=                   " No beep or flash
set timeoutlen=500             " Wait 0.5 s for a key sequence to complete

set wildmode=longest:full      " Show all matches for tab-completing file names
set wildmenu                   " Turn on wild menu

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
" Use par for paragraph formatting
if executable("par")
  set formatprg=par\ 80gqs0
endif

" Starts in maximized mode
if has('gui')
  if has('win32')
    au GUIEnter * :set lines=99999 columns=99999
  elseif has('gui_gtk2')
    au GUIEnter * :set lines=99999 columns=99999
  elseif has("gui_running")
    " GUI is running or is is about to start.
    " Maximize gvim window
    set lines=999 columns=999
  else
    " This is console VIM
    if exist("+lines")
      set lines=50
    endif
    if exist("+columns")
      set columns=100
    endif
  endif
endif


" Navigate by display lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Fuzzy search through help with FuzzyFinder
nnoremap <c-h> :FufHelp<CR>

"------------------------------------------------------------------------------
" Windows
"------------------------------------------------------------------------------
if is_windows
  " Turn off obnoxious path abbreviation in Gvim
  set guitablabel=%t

  " Set a font for double-width characters
  set guifontwide=MS\ Mincho:h10:cANSI

  " Semicolon is pretty useless, and colon requires pressing shift
  nnoremap ; :
endif

"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------
let mapleader=","              " Set leader to comma

" Fast editing and updating of .vimrc
execute "nnoremap <leader>v :e! " . vimfiles_path . "vimrc<CR>"
execute "autocmd! bufwritepost vimrc source " . vimrc_path

"------------------------------------------------------------------------------
" Indent
"------------------------------------------------------------------------------
set autoindent               " Automatically indent
set expandtab                " Use spaces instead of tabs
set smartindent              " Smartly insert an extra level of indentation
set softtabstop=2            " Indent two spaces when pressing tab
set shiftwidth=2             " Indent two spaces
set showmatch                " Jump to match when found

set number                   " Show line number
set ruler                    " Show line and column number in lower right
set nowrap                   " Don't wrap text
set incsearch                " Search incrementally
set hlsearch                 " Highlight search results
set mat=2                    " How many tenths of a second to blink

set linebreak                " Break on word barriers
set showbreak=>>>            " Line break shown as >>>

set textwidth=100            " No maximum width of text for insertion
set wrapmargin=0             " Turn off automatic insertion of newlines

set nojoinspaces             " Don't add two spaces between joined sentences

" Turn off search highlighting if it gets annoying
nnoremap <leader>n :nohlsearch<CR>
nnoremap <leader>w :set wrap!<CR>

" Rehighlight text after indentation in visual mode
vnoremap < <gv
vnoremap > >gv

"------------------------------------------------------------------------------
" Insert mode
"------------------------------------------------------------------------------
" Ctrl+Backspace deletes previous word
inoremap <D-BS> <C-W>

" More natural keybindings in insert mode for Mac
inoremap <M-Left> <C-Left>
inoremap <M-Right> <C-Right>
inoremap <D-Left> <Home>
inoremap <D-Right> <End>

" Selecting text
inoremap <S-D-Left> <S-Home>
inoremap <S-D-Right> <S-End>
inoremap <S-M-Left> <S-C-Left>
inoremap <S-M-Right> <S-C-Right>
snoremap <S-D-Left> <S-Home>
snoremap <S-D-Right> <S-End>
snoremap <S-M-Left> <S-C-Left>
snoremap <S-M-Right> <S-C-Right>

"------------------------------------------------------------------------------
" Tabular
"------------------------------------------------------------------------------
" Shortcuts for aligning tables with common delimiters
if exists(":Tabularize")
  " Vertical bars
  nnoremap <leader>t<Bar> :Tabularize /\|<CR>
  vnoremap <leader>t<Bar> :Tabularize /\|<CR>

  " Equal signs
  nnoremap <leader>t= :Tabularize /=<CR>
  vnoremap <leader>t= :Tabularize /=<CR>

  " Colons
  nnoremap <leader>t: :Tabularize /:\zs/l0l1<CR>
  vnoremap <leader>t: :Tabularize /:\zs/l0l1<CR>

  " Commas
  nnoremap <leader>t, :Tabularize /,\zs/l0l1<CR>
  vnoremap <leader>t, :Tabularize /,\zs/l0l1<CR>

  " Hashrockets
  nnoremap <leader>t> :Tabularize /=><CR>
  vnoremap <leader>t> :Tabularize /=><CR>
endif

"------------------------------------------------------------------------------
" Language
"------------------------------------------------------------------------------

" Remap ¥ to \ for command line
cnoremap ¥ <Bslash>

set noimd                      " Retain input method editor memory for modes

"------------------------------------------------------------------------------
" Colors and fonts
"------------------------------------------------------------------------------
syntax enable                  " Enable syntax highlighting

" Define vim-one colorscheme
set background=light 
colorscheme one
let g:airline_theme='one'

"------------------------------------------------------------------------------
" Vim airline
"------------------------------------------------------------------------------
set laststatus=2               "Show airline without splitting 

" Show tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0 "Hide buffers

" Adding patched fonts
let g:airline_powerline_fonts = 1

"------------------------------------------------------------------------------
" CtrlP.vim
"------------------------------------------------------------------------------

" Rebind
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

" Working path mode
let g:ctrlp_working_path_mode = 'ra'

" Remaping to open files in new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }


"------------------------------------------------------------------------------
" Files
"------------------------------------------------------------------------------
set nobackup                   " Don't create a permanent backup when writing
set nowritebackup              " Don't make a temporary backup either
set noswapfile                 " Don't use a swapfile for the buffer

" Easily switch between buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
map <leader>, :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" Notes
"------------------------------------------------------------------------------
" Write to Documents/Notes by default
let g:notes_directory='~/Documents/Notes'

" No smart quotes
let g:notes_smart_quotes=0

"------------------------------------------------------------------------------
" LaTeX
"------------------------------------------------------------------------------
set shellslash                 " For Win32
set grepprg=grep\ -nH\ $*      " Always generate a filename
let g:tex_flavor='latex'       " Default to LaTeX instead of PlainTeX

"------------------------------------------------------------------------------
" Regular expressions
"------------------------------------------------------------------------------
" Default searches to very magic (special characters don't need escaping)
nnoremap / /\v/<Left>
nnoremap ? ?\v/<Left>
nnoremap <leader>/ :%s/\v/g<Left><Left>
nnoremap <leader>; :%s/\v^\+.*\zs/g<Left><Left>

" Copy current word or selection and replace for the entire document
nnoremap <leader>s yiw:%s/\<<C-r>"\>//gc<Left><Left><Left>
vnoremap <leader>s y:%s/\<<C-r>"\>//gc<Left><Left><Left>

" Count number of occurrences for the current or selected word
nnoremap <leader>m yiw:%s/\<<C-r>"\>//gn<CR><C-O>
vnoremap <leader>m y:%s/\<<C-r>"\>//gn<CR><C-O>

" Case-insensitive unless capital letter is included
set ignorecase
set smartcase

set report=0                   " Notify how many replacements were made

"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------
" Fix weird mapping for applescript
autocmd BufReadPost *.applescript set filetype=applescript

" Quick remapping for colored column
nnoremap <leader>c :set colorcolumn=0<Left>

" SuperTab
let g:SuperTabDefaultCompletionType="context"

" Map MacVim keybindings for changing tabs to same as Mac Terminal
let macvim_skip_cmd_opt_movement=1
nnoremap <S-D-Right> :tabnext<CR>
nnoremap <S-D-Left> :tabprevious<CR>

" New tab shortcut for Windows
if is_windows
  nnoremap <C-T> :tabnew<CR>
endif

" Spellcheck
nnoremap <leader>sc :! aspell -c %<CR>

" Update configuration from GitHub repo
execute "nnoremap <leader>u :!cd " . vimfiles_path . " && git pull origin master && git submodule foreach git pull origin master<CR>"

" Add new plugin
execute "nnoremap <leader>x :!cd " . vimfiles_path . " && git submodule add git://github.com/"
execute "nnoremap <leader>xu :!cd " . vimfiles_path . " && git submodule init && git submodule update<CR><CR>"

" Load custom additions to vimrc
if is_windows
  if filereadable($HOME . "/_vimrc_custom")
    source $HOME/_vimrc_custom
  endif
else
  if filereadable($HOME . "/.vimrc_custom")
    source $HOME/.vimrc_custom
  endif
endif
