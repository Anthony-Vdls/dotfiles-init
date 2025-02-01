"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""    
" .vimrc intro ----------------------------------------------------------- {{{

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" This automatically installs vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

" sets & maps ----------------------------------------------------------- {{{

filetype on
filetype plugin on
filetype indent on
syntax on

set nu
set ru
set spell
set spelllang=en_us
set cursorline
set ignorecase
set showmode 
set laststatus=2

set tabstop=4		" Tabs are at proper coloms
" set expandtab		" Dont use acutal tab char
set shiftwidth=4	" Indent is 4 spaces
set autoindent		" That
set smartindent		" Brings it to mach margins
set pastetoggle=<f5>	" Dont auto indent when pasting
set clipboard=unnamedplus " Enables system clipboard use
set fileformat=unix " Ensures handling of unix files

" This adds auto complete from dictinary 
" set dictionary=/usr/share/dict/words

" Mapping for freqently typed stuff
imap ;pr System.out.println();<left><left>
imap ;main public static void main(String args[]) 
imap ;if if(...){...} 

" Should enable mouse pop ups
set mouse=a
set mousemodel=popup_setpos

" Sets moves all the extra files inside .vim
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Most of these are enabled for Java 
set wildmenu    " Enable auto completion menu after pressing TAB.
set wildmode=list:longest " Make it behave like similar to Bash completion.

" map_mode <what_you_type> <what_is_executed>
" nnoremap – Allows you to map keys in normal mode.
nnoremap n nzz
nnoremap N Nzz
nnoremap <space> :
" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Map the F3 key to toggle NERDTree open and close.
nnoremap ff :NERDTreeToggle<cr>


" inoremap – Allows you to map keys in insert mode.
inoremap jj <esc>
" vnoremap – Allows you to map keys in visual mode.

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use ENTER to confirm the selected suggestion
" inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"
"
inoremap <silent><expr> <c-space> coc#refresh()

" Use Alt+j and Alt+k to navigate through coc.nvim's completion suggestions
inoremap <silent><expr> <A-j> pumvisible() ? "\<C-n>" : "\<A-j>"
inoremap <silent><expr> <A-k> pumvisible() ? "\<C-p>" : "\<A-k>"

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Enable foldmethod=manual for programming languages
augroup folding_by_manual
  autocmd!
  autocmd FileType java,python,c setlocal foldmethod=manual
augroup END


" Persist folds across sessions
" augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * silent! mkview
"  autocmd BufWinEnter * silent! loadview
" augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

" Ensures that downloaded plugs are unix files
autocmd BufRead,BufNewFile * setlocal fileformat=unix

call plug#begin('~/.vim/plugged')

  Plug 'preservim/nerdtree' " :NERDTree

  Plug 'dense-analysis/ale' " :Error Correction

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'morhetz/gruvbox' " :Theme
  

call plug#end()

" Themes have to be called after plug calls.
 set background=dark
 colorscheme gruvbox


" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

" NOTES ------------------------------------------------------------------ {{{

"These are all helpful commands that could be forgoten
"    Vim folding commands
"---------------------------------
"zf#j creates a fold from the cursor down # lines.
"zf/ string creates a fold from the cursor to string .
"zj moves the cursor to the next fold.
"zk moves the cursor to the previous fold.
"za toggle a fold at the cursor.
"zo opens a fold at the cursor.
"zO opens all folds at the cursor.
"zc closes a fold under cursor. 
"zm increases the foldlevel by one.
"zM closes all open folds.
"zr decreases the foldlevel by one.
"zR decreases the foldlevel to zero -- all folds will be open.
"zd deletes the fold at the cursor.
"zE deletes all folds.
"[z move to start of open fold.
"]z move to end of open fold.
"
"This is how to search 
"?<string_to_search> hit Enter then u or U to find next instance
"
"
" }}}
