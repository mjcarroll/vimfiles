set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

set background=dark " Assume a dark background
filetype plugin indent on " Automatically detect file types.
syntax on " Syntax highlighting
set mouse=a " Automatically enable mouse usage
set mousehide " Hide the mouse cursor while typing
scriptencoding utf-8

if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui') " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

 "set autowrite " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore " Allow for cursor beyond last character
set history=1000 " Store a ton of history (default is 20)
set spell " Spell checking on
set hidden " Allow buffer switching without saving

set backup " Backups are nice ...
if has('persistent_undo')
    set undofile " So is persistent undo ...
    set undolevels=1000 " Maximum number of changes that can be undone
    set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
endif

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
	let g:solarized_termcolors=256
	color ir_black " Load a colorscheme
endif
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set tabpagemax=15 " Only show 15 tabs
set showmode " Display the current mode

set cursorline " Highlight current line

highlight clear SignColumn " SignColumn should match background for

if has('cmdline_info')
	set ruler " Show the ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
	set showcmd " Show partial commands in status line and
endif

if has('statusline')
	set laststatus=2
	set statusline=%<%f\ " Filename
	set statusline+=%w%h%m%r " Options
	set statusline+=%{fugitive#statusline()} " Git Hotness
	set statusline+=\ [%{&ff}/%Y] " Filetype
	set statusline+=\ [%{getcwd()}] " Current dir
	set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

set backspace=indent,eol,start " Backspace for dummies
set linespace=0 " No extra spaces between rows
set nu " Line numbers on
set showmatch " Show matching brackets/parenthesis
set incsearch " Find as you type search
set hlsearch " Highlight search terms
set winminheight=0 " Windows can be 0 line high
set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set foldenable " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

let mapleader = ','

map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
	\if &omnifunc == "" |
	\setlocal omnifunc=syntaxcomplete#Complete |
	\endif
endif

set completeopt-=preview

nmap <silent> <leader>/ :set invhlsearch<CR>
vnoremap < <gv
vnoremap > >gv

set nowrap
set autoindent
set expandtab

set tabstop=4
set softtabstop=4
set shiftwidth=4

hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" Some convenient mappings
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

let parent = $HOME
let prefix = 'vim'
let dir_list = {
	\ 'backup': 'backupdir',
	\ 'views': 'viewdir',
	\ 'swap': 'directory' }

if has('persistent_undo')
	let dir_list['undo'] = 'undodir'
endif

let common_dir = parent . '/.' . prefix

for [dirname, settingname] in items(dir_list)
	let directory = common_dir . dirname . '/'
	if exists("*mkdir")
		if !isdirectory(directory)
			call mkdir(directory)
		endif
	endif
	if !isdirectory(directory)
		echo "Warning: Unable to create backup directory: " . directory
		echo "Try: mkdir -p " . directory
	else
		let directory = substitute(directory, " ", "\\\\ ", "g")
		exec "set " .settingname . "=" . directory
	endif
endfor

