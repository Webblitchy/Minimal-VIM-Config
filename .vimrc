""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                    "
"              ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗               "
"              ██║   ██║██║████╗ ████║██╔══██╗██╔════╝               "
"              ██║   ██║██║██╔████╔██║██████╔╝██║                    "
"              ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║                    "
"               ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗               "
"                ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝               "
"                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ######## FILE FORMATS #######
set encoding=utf-8
scriptencoding utf-8
set fileformat=unix

" ###### BEFORE ALL #####
let mapleader = "-" " Define leader key
autocmd BufEnter * silent! lcd %:p:h " automatically set vim path to current dir

" ############## BEHAVOURS #############

" KEYS BEHAVOURS

set backspace=indent,eol,start  " more powerful backspacing

" Indentation settings
set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set expandtab " expand tabs to spaces 
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=4 " number of spaces to use for autoindenting
set smartindent
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=4 " tabs are n spaces 


" Timeout before a command key stop waiting
set timeoutlen=500    " Timeout before a command key stop waiting
set ttimeoutlen=0     " Remove timeout when hitting escape (ex: V-mode)

set autoread              " Automatically reload changes if detected


set belloff=all           " Disable error bell

" SEARCH
set ignorecase            " Case insensitive search
set smartcase             " Sensible to capital letters
set incsearch             " Show search results as you type
nnoremap <silent> <CR> :noh<CR><CR>" Disable highlight when pressing enter again

" HISTORY
" Persistent undo
silent call mkdir($HOME."/.vimundo", "p") " create folder if not existing
set undodir=~/.vimundo
set undofile
set undolevels=1000
set undoreload=10000

set history=1000                     " Command history

set nobackup writebackup

set noswapfile " disable the swapfile

" ##### :command auto completion #####
" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.xlsx,*.bin


set confirm " prompt for saving instead of error

" ############### UI ###############

" apply color for syntax
syntax on
"set termguicolors " show real colors

set title " display file name on window title
set showcmd " show live command

set number  " Current line number
set relativenumber  " Relative line numbers

set showmatch                         " Show matching brackets
set matchpairs=(:),{:},[:],<:>

" keep lines under cursor
function! SetAutoScrolloff()
    let quarterOfHeight = winheight(0) / 3
    execute ':set scrolloff=' . quarterOfHeight
endfunction
autocmd! VimResized,VimEnter,WinEnter,WinLeave * call SetAutoScrolloff()

set list                              " Enable listchars
" Invisible char and their representation
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set listchars+=tab:⊦—▸
set listchars+=trail:·

" Color current line number
""
colorscheme darkblue
set cursorline
set cursorlineopt=number
hi Normal guibg=NONE ctermbg=NONE   " transparent background

" Enable color highlighting inside markdown code blocs
let g:markdown_fenced_languages = ['python', 'cpp', 'c', 'java', 'rust', 'bash', 'css', 'js=javascript', 'html']

" Change the cursor lenght in function of the mode (VTE compatible terminals)
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom

set shortmess=I                       " disable start message

set signcolumn=yes                     " Always have a sign and number columns
"set signcolumn=number                 " Fusion sign and number columns
hi SignColumn ctermbg=NONE guibg=NONE  " Sign column has same color as number column

function! SetupEnvironment()
    "Restore cursor position
    if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Set wrapping/textwidth according to type
    if (&ft == 'markdown' || &ft == 'text' || &ft == 'html')
        setlocal wrap
    else
        " default textwidth slightly narrower than the default
        setlocal nowrap
    endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()


" Remove the ugly splits separator
set fillchars=vert:\│
hi VertSplit term=NONE cterm=NONE gui=NONE ctermfg=DarkGrey


" automatically create the folder if not already exists
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END



" ############ COMMANDS ############
" Command W : save as root (when file is not open as it)
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!



" ################ REMAPS / SHORTCUTS ################

" to make ctrl-c behave exactly like esc
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" to make TAB rotate between all buffers
nnoremap <silent> <TAB> :bn<CR>

" close buffer with --
nnoremap <silent> <leader>- :bd<CR>


" register macro with qq and play it with Q
nnoremap Q @q

" use Y with the same logic as C and D
nnoremap Y y$

" Navigate easily between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Resize easily windows
map <s-LEFT> :vertical resize +5 <Cr>
map <s-RIGHT> :vertical resize -5 <Cr>
map <s-UP> :resize +5 <Cr>
map <s-DOWN> :resize -5 <Cr>


