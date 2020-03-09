"Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

" The bundles you install will be listed here
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Plugin 'morhetz/gruvbox'
Plugin 'baskerville/bubblegum'
Plugin 'scrooloose/nerdtree'
Plugin 'ap/vim-css-color'
Plugin 'junegunn/goyo.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-pencil'
Plugin 'lervag/vimtex'
Plugin 'jceb/vim-orgmode'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/utl.vim'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-speeddating'
Plugin 'mattn/calendar-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'

Plugin 'Tarrasch/pddl.vim'

call vundle#end() 
filetype plugin indent on

" Relative Numbers
let relative_blacklist = ['org', 'calendar']
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set norelativenumber
:au FocusGained * if index(relative_blacklist, &ft) < 0 | :set relativenumber

" Remap <C-W>h,j,k,l to <C-h,j,k,l>
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

" nonumber Tagbar
map <F3> :TagbarToggle<cr>

" .nvimrc truecoloe support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Vim-Orgmode
let g:org_aggressive_conceal = 1 "Hide format characters
let g:org_agenda_files = ['~/org/agenda.org']
let g:org_indent = 1
let g:org_prefer_insert_mode = 0
let g:org_todo_keywords = [['TODO(t)', 'WAITING(w)', '|', 'DONE(d)'], ['|', 'CANCELED(c)']]
let g:org_todo_keyword_faces = [['WAITING', 'cyan'], ['CANCELED', [':foreground red', ':weight bold']]]

" Calendar
let g:calendar_monday = 1

" Set background for these filetypes
" au Filetype org set background=light nonumber

set mouse=a	" Enable mouse usage (all modes)
set number	" Numeros de cada linea
set autoindent cindent smartindent showmatch
set softtabstop=4
set shiftwidth=4
set tabstop=4
set modifiable

" Set utf8 as standard encoding and en_US as the standard language
"set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"Teclas Mapeadas
map <F2> :NERDTreeToggle<cr>

"NerdTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"YCM
"Configuracion para completado en C/C++
"Lista negra para archivos en YCM
"let g:ycm_filetype_blacklist = { 'python' : 1,  'py' : 1}
"LA POYITA PARA AUTOCOMPLETADO C++
let g:ycm_global_ycm_extra_conf= '~/.vim/.ycm_extra_conf.py'
"let g:ycm_path_to_python_interpreter= '/usr/bin/python2'

"Jedi-Vim
let g:jedi#completions_enabled = 0
let g:jedi#force_py_version = 2 "Cambiar dependiendo de la version en uso

"vim-airline
set guifont=Monaco\ for\ Powerline:h9
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode "No aparece el indicador de modos
set timeoutlen=50 "Elimina retardo cambio modo insertar a normal 
set timeoutlen=1000 ttimeoutlen=0
" let g:airline#extensions#tabline#enabled=1 "Tabs modo airline
set t_Co=1
let g:bufferline_echo = 0 " Para que buefferline no aparezca en la barra de comandos
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_theme='bubblegum'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  "let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  "let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" vim-bufferline
let g:bufferline_solo_highlight = 0

"Goyo
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

"vim-markdown
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'csharp=cs']

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = ['pylint', 'pep8']
let g:pymode_lint_on_fly = 0
" Auto check on save
let g:pymode_lint_write = 1
" Trim unused white spaces
let g:pymode_trim_whitespaces = 1
" Columna de mierda que sale a la derecha
let g:pymode_options_colorcolumn = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
set notimeout "No leader timeout
let mapleader = "\<space>"
"let g:mapleader = ","
let maplocalleader = "\<space>"
"let g:maplocalleader = ","


" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
"set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" Busqueda incremental
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
"set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

set background=light " Colores en negrita
let g:solarized_termcolors=256
colorscheme solarized

" dont set background
hi Normal ctermbg=NONE

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
"set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
noremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
