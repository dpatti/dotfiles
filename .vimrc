" --- Options ---------------------------------------------------------------{{{
set nocompatible        " Disable vi compatability
set ffs=unix            " File format prefer unix endings
set eol                 " Add newline at end of file
set shellslash          " Use forward slashes for file names
set vb                  " Visual bell instead of beep
set nobk                " Do not use backup files
set formatoptions=croql " Format options: wrap (c)omments at textwidth, insert comment leade(r), and unknown
set textwidth=80        " 80 characters wide
set hidden              " Allow unsaved buffers to be hidden
set laststatus=2        " Always use status line
set showmode            " Display current mode
set ch=2                " Command line two lines high
set wildmenu            " Command line completion helper
set wildignorecase      " Ignore case when tab-completing files
set timeoutlen=500      " Timeout for remaps
set history=100         " Keep some stuff in the history
set mousehide           " Hide the mouse pointer while typing
set scrolloff=8         " Always keep cursor 8 lines from edge
set virtualedit=all     " Allow the cursor to go to invalid places
set synmaxcol=1024      " Disable coloring on long lines (helps with large files)
set cul                 " Highlight current line
set nowrap              " Disable wrapping by default
set backspace=2         " Allow backspace over indent, eol, and start of insert
set cpoptions+=$        " Change commands will display a $ to mark end of changed text
set hlsearch            " Search highlights
set wrapscan            " Search will continue past end of document
set incsearch           " Search as you type
set ignorecase          " Search will ignore case
set smartcase           " Search will respect case if any letter is uppercase
set showcmd             " Show command in bottom-right as you type it
set hls                 " Highlight search
set nojoinspaces        " Joining or formatting lines will not add two spaces after a period
set autoread            " Automatically load files that change if they haven't changed in vim
set shortmess+=c        " No completion menu errors as you're typing
set lazyredraw
set ttyfast
set display+=lastline   " Shows partial lines instead of @@@@
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set autoindent
syntax on               " Turn on syntax highlighting

" Suffixes to de-prioritize
set suffixes+=.pyc      " Python compiled

" Tabstops are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker   " Use {{{ }}} for folds

" Filetype specific stuff
filetype plugin indent on
" --- }}}

" --- Mappings --------------------------------------------------------------{{{
let mapleader=","       " Set the <Leader> key to comma

" Moving between wrapped lines
nnoremap k gk
nnoremap j gj

" Indent modification keeps visual mode
vnoremap > >gv
vnoremap < <gv

" Mappings for easy toggle between 2 and 4 depending on document
nmap <silent> ,2 :set tabstop=2 softtabstop=2 shiftwidth=2<cr>
nmap <silent> ,4 :set tabstop=4 softtabstop=4 shiftwidth=4<cr>

" Use Ctrl+C and Ctrl+V to copy/paste in their respective modes
vnoremap <C-X> "+x
vnoremap <C-C> "+y
inoremap <C-V> <C-O>"+gP
cnoremap <C-V> <C-R>+

" Remap the old C-V in insert mode (escape sequence)
" inoremap <C-S-V> <C-V>

" Let's make it easy to edit/source this file ('e'dit 'v'imrc)
nmap <silent> ,ev :e $HOME/.vimrc<cr>
nmap <silent> ,sv :so $HOME/.vimrc<cr>

" Set text wrapping toggles
nmap <silent> ,w :set invwrap<cr>:set wrap?<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<cr>:set paste?<cr>

" Turn off higlight search
nmap <silent> ,n :set invhls<cr>:set hls?<cr>
" Clear highlight search
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" cd to directory of file in buffer
nmap <silent> ,cd :lcd %:h<cr>

" Move the cursor to different windows
noremap <silent> ,h :wincmd h<cr>
noremap <silent> ,j :wincmd j<cr>
noremap <silent> ,k :wincmd k<cr>
noremap <silent> ,l :wincmd l<cr>

" Ctrl+Backspace to delete prev word
imap <C-BS> <C-W>
cmap <C-BS> <C-W>

" Change Y to be more consistent with C, D, etc.
map Y y$

" Session management
map <F2> :mksession! .vim_session <cr>
map <F3> :source .vim_session <cr>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Diff (t)his, Diff (o)ff!
nmap <silent> ,dt :difft<cr>
nmap <silent> ,do :diffo!<cr>:windo set nowrap foldmethod=marker<cr>

" Fold methods
nmap <silent> ,fm :set foldmethod=marker<cr>
nmap <silent> ,fi :set foldmethod=indent<cr>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" Slide cursor to the next/previous line of the same indent level
nnoremap <silent> <C-K> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> <C-J> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
" --- }}}

" --- Plugin config ---------------------------------------------------------{{{
" plug
call plug#begin('~/.vim/bundle')

" Languages
" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'burnettk/vim-angular'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'flowtype/vim-flow'
Plug 'mxw/vim-jsx'
" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/neco-ghc'
" Misc
Plug 'tpope/vim-git'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-markdown'
Plug 'juvenn/mustache.vim'
Plug 'rodjek/vim-puppet'
Plug 'othree/html5.vim'

" Tools
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'rbong/vim-vertical'
Plug 'shougo/vimproc.vim', { 'do': 'make' }

" Visual
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'chriskempson/base16-vim'
call plug#end()

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-ruby
let ruby_no_expensive=1

" ack
cnoreabbrev A Ack!
nmap <silent> <C-A> :Ack!<CR>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" coffee-script
command! -range=% CC <line1>,<line2>CoffeeCompile

" syntastic
let g:syntastic_cpp_compiler_options = ' -std=c++0x'
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
let g:syntastic_javascript_flow_exec = 'node_modules/.bin/flow'

" git gutter
let g:gitgutter_realtime = 0
nmap <silent> ,m :GitGutterNextHunk<CR>
nmap <silent> ,M :GitGutterPrevHunk<CR>

" NERD Tree Plugin
nmap <F7> :NERDTreeToggle<CR>

" Powerline
let g:airline_section_y = '0x%02B'
let g:airline_theme = 'base16_tomorrow'
let g:airline_powerline_fonts = 0
let g:airline_skip_empty_sections = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" Indent Guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 2
hi IndentGuidesOdd guibg=#1a1a1a ctermbg=NONE
hi IndentGuidesEven guibg=#151515 ctermbg=NONE

" Ctrl+P
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ycm
let g:ycm_semantic_triggers = {'haskell': ['re!.']}

" bufkill
nnoremap <silent> <Leader>bd :BD<CR>
nnoremap <silent> <Leader>bD :BD!<CR>
nnoremap <silent> <Leader>BD :BD!<CR>

" multiple-cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 1

" vim-vertical (overwrites C-K and C-J above)
if exists(':Vertical')
  nnoremap <silent> <C-K> :Vertical b<CR>
  nnoremap <silent> <C-J> :Vertical f<CR>
end

" vim-flow
nmap <silent> ,ft :FlowType<cr>

" neco-ghc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" --- }}}

" --- Style and font --------------------------------------------------------{{{
set background=dark
let base16colorspace=256

if has('gui_running')
  colorscheme base16-tomorrow-night
elseif &t_Co == 256
  colorscheme base16-tomorrow-night
else
  colorscheme default
endif

if has("gui_gtk2")
  set guifont=Hack\ 10
else
  set guifont=Hack:h13
endif

set colorcolumn=81,121
" --- }}}

" --- Custom commands -------------------------------------------------------{{{
" fill rest of line with characters
function! FillLine( str )
  " set tw to the desired total length
  let tw = &textwidth
  if tw==0 | let tw = 80 | endif
  " strip trailing spaces first
  .s/[[:space:]]*$//
  " calculate total number of 'str's to insert
  let reps = (tw - col("$")) / len(a:str)
  " insert them, if there's room, removing trailing spaces (though forcing
  " there to be one)
  if reps > 0
    .s/$/\=(' '.repeat(a:str, reps))/
  endif
endfunction
nmap <silent> ,cl :call FillLine('-')<cr>

" Open terminal at current location
function! Terminal()
  if has("unix")
    execute "!gnome-terminal --working-directory='" . getcwd() ."' &"
  endif
endfunction
nmap <silent> ,ct :call Terminal()<cr>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" --- }}}

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
