" --- Options ---------------------------------------------------------------{{{
set nocompatible        " Disable vi compatability
set ffs=unix            " File format prefer unix endings
set eol                 " Add newline at end of file
set shellslash          " Use forward slashes for file names
set visualbell          " Visual bell instead of beep
set nobackup            " Do not use backup files
set noswapfile          " Do not use swap files
set undodir=~/.vim/tmp/undo
set undofile
set formatoptions=croql " Format options: wrap (c)omments at textwidth, insert comment leade(r), and unknown
set textwidth=80        " 80 characters wide
set hidden              " Allow unsaved buffers to be hidden
set laststatus=2        " Always use status line
set showmode            " Display current mode
set ch=2                " Command line two lines high
set wildmenu            " Command line completion helper
set wildignorecase      " Ignore case when tab-completing files
set timeoutlen=500      " Timeout for remaps
set ttimeoutlen=10      " Timeout for escape sequences
set history=100         " Keep some stuff in the history
set mousehide           " Hide the mouse pointer while typing
set scrolloff=8         " Always keep cursor 8 lines from vertical edge
set sidescrolloff=3     " Always keep cursor 3 lines from horizontal edge
set virtualedit=all     " Allow the cursor to go to invalid places
set synmaxcol=1024      " Disable coloring on long lines (helps with large files)
set cul                 " Highlight current line
set nowrap              " Disable wrapping by default
set linebreak           " Try to break at a nice character
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
set pumheight=10        " Show no more than 10 items in the popup window
set completeopt+=menuone " Show completion popup even if there is one suggestion
set completeopt+=noselect " Don't select, just pop up
set completeopt-=preview  " Don't show preview window
set lazyredraw
set ttyfast
set display+=lastline   " Shows partial lines instead of @@@@
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set autoindent
set viminfo+=%          " save buffer list on exit
set nostartofline       " movement keys don't also move your cursor to start of line (G, C-D, etc)
set report=0            " report how many lines a : command changes
syntax on               " Turn on syntax highlighting

set comments-=n:>       " > is not a comment
set comments+=b:>       " okay it kind of is, but only when there's a space after (i don't think 'n' works with 'b')

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
nnoremap <silent> k gk
nnoremap <silent> j gj

" Indent modification keeps visual mode
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" Mappings for easy toggle between 2 and 4 depending on document
nmap <silent> ,2 :set tabstop=2 softtabstop=2 shiftwidth=2<cr>
nmap <silent> ,4 :set tabstop=4 softtabstop=4 shiftwidth=4<cr>

" Use Ctrl+C and Ctrl+V to copy/paste in their respective modes
if has("clipboard")
  vnoremap <C-X> "+x
  vnoremap <C-C> "+y
  inoremap <C-V> <C-O>"+gP
  cnoremap <C-V> <C-R>+
endif

" Remap the old C-V in insert mode (escape sequence)
" inoremap <C-S-V> <C-V>

" Let's make it easy to edit/source this file ('e'dit 'v'imrc)
nmap <silent> ,ev :e $HOME/.vimrc<cr>
nmap <silent> ,sv :so $HOME/.vimrc<cr>

" Set text wrapping toggles
nmap <silent> ,w :set invwrap<cr>:set wrap?<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<cr>:set paste?<cr>

" Toggle text wrap
nmap <silent> ,t :if stridx(&fo, 't') == -1 \| set fo+=t \| else \| set fo-=t \| endif<cr>:set fo?<cr>

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

" lookup keyword is almost never used, invert J instead
nnoremap K i<CR><Esc>k$

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" Slide cursor to the next/previous line of the same indent level
nnoremap <silent> <C-K> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent> <C-J> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

" Tabs
nnoremap <silent> <A-[> :tabprevious<CR>
nnoremap <silent> <A-]> :tabnext<CR>

" Command abbreviations
cnoreabbrev CWD %:h
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
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'raichoo/purescript-vim'
Plug 'FrigoEU/psc-ide-vim'
" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
" Haskell
Plug 'neovimhaskell/haskell-vim'
" I really don't know what works. I'm kind of holding out for
" https://github.com/w0rp/ale/issues/1578
if 0
Plug 'eagletmt/neco-ghc'
Plug 'bitc/vim-hdevtools'
endif
" Ocaml
Plug 'ocaml/vim-ocaml'
Plug 'ocaml/merlin', { 'rtp': 'vim/merlin' }
Plug 'copy/deoplete-ocaml'
" Misc
Plug 'tpope/vim-git'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-markdown'
Plug 'juvenn/mustache.vim'
Plug 'rodjek/vim-puppet'
Plug 'othree/html5.vim'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'rust-analyzer/rust-analyzer'
Plug '887/cargo.vim'

" Tools
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'ervandew/supertab'
endif
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'rbong/vim-vertical'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'sjl/gundo.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'w0rp/ale'
Plug 'kana/vim-altr'
Plug 'godlygeek/tabular'
Plug 'thaerkh/vim-workspace'
Plug 'AndrewRadev/linediff.vim'
Plug 'pixelastic/vim-undodir-tree'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'

" Visual
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

" ale
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
      \ 'haskell': ['hie', 'hlint', 'hdevtools', 'stack-build'],
      \ 'ocaml': ['merlin'],
      \ 'rust': ['cargo', 'rls'],
      \}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'ocaml': ['ocamlformat'],
      \ 'javascript': ['prettier'],
      \ 'javascriptreact': ['prettier'],
      \ 'json': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ 'rust': ['rustfmt'],
      \}
nmap <silent> ,ft :ALEHover<cr>
nmap <silent> ,fg :ALEGoToDefinition<cr>
nmap <silent> ,fd :ALEGoToTypeDefinition<cr>
nmap <silent> ,fn :ALENextWrap<cr>

" linediff
nnoremap <silent> ,dm :LinediffMerge<CR>
nnoremap <silent> ,dk :LinediffPick<CR>
nnoremap <silent> ,dr :LinediffReset<CR>
vnoremap <silent> ,da :LinediffAdd<CR>
vnoremap <silent> ,db :LinediffLast<CR>

" startify
let g:startify_list_order = [
      \ ['Most recently used'],
      \ 'dir',
      \ ['Bookmarks'],
      \ 'bookmarks',
      \ ['Sessions'],
      \ 'sessions',
      \ ['Commands'],
      \ 'commands',
      \ ]
let g:startify_commands = [
      \ {'l': ['project tree', 'e .']}
      \ ]
let g:startify_custom_header = [getcwd()]
let g:startify_change_to_dir = 0
nnoremap <silent> ~ :Startify<CR>

" vim-altr
nmap <leader>a <Plug>(altr-forward)
call altr#define('%/%.ml', '%/%.mli', '%/%_intf.ml', '%/%0.ml', '%/%0.mli', '%/%1.ml', '%/%1.mli', '%/%.mly')

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-ruby
let ruby_no_expensive=1

" ack
cnoreabbrev A Ack!
nmap <silent> <C-A> :Ack!<CR>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" coffee-script
command! -range=% CC <line1>,<line2>CoffeeCompile

" git gutter
let g:gitgutter_realtime = 0
let g:gitgutter_map_keys = 0
nmap <silent> ,m :GitGutterNextHunk<CR>
nmap <silent> ,M :GitGutterPrevHunk<CR>

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

" fzf.vim
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <C-P> :FzfGitFiles<CR>
nnoremap <silent> <C-B> :FzfBuffers<CR>
nnoremap <silent> <C-T> :FzfMerlin<CR>

" deoplete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
" tab to complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<S-TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

call deoplete#custom#option('sources.ocaml', ['ocaml', 'buffer', 'around', 'member', 'tag'])
call deoplete#custom#source('_', 'max_abbr_width', 0)
call deoplete#custom#source('_', 'max_menu_width', 0)

" supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'
let g:SuperTabLongestHighlight = 0

" bufkill
nnoremap <silent> <Leader>bd :BD<CR>
nnoremap <silent> <Leader>bD :BD!<CR>
nnoremap <silent> <Leader>BD :BD!<CR>

" multiple-cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 1

" vim-vertical (overwrites C-K and C-J above)
nnoremap <silent> <C-K> :Vertical b<CR>
nnoremap <silent> <C-J> :Vertical f<CR>

" vim-surround
vmap s S

" vim-flow
let g:flow#flowpath = 'node_modules/.bin/flow'
" I should switch to using ALE
" autocmd FileType javascript nmap <buffer> <silent> ,ft :FlowType<cr>

" psc-ide-vim
autocmd FileType purescript nmap <buffer> <silent> ,ft :PSCIDEtype<cr>
autocmd FileType purescript nmap <buffer> <silent> ,fg :PSCIDEgoToDefinition<cr>
autocmd FileType purescript nmap <buffer> <silent> ,fi :PSCIDEimportIdentifier<cr>
autocmd FileType purescript nmap <buffer> <silent> ,fa :PSCIDEaddTypeAnnotation<cr>
autocmd FileType purescript nmap <buffer> <silent> ,fs :PSCIDEapplySuggestion<cr>
autocmd FileType purescript nmap <buffer> <silent> ,fr :PSCIDEload<cr>

" vim-workspace
let g:workspace_session_name = '.session.vim'
let g:workspace_autosave = 0
let g:workspace_autosave_untrailspaces = 0

" gundo
if has('python3')
  let g:gundo_prefer_python3 = 1
endif
nnoremap <silent> ,gt :GundoToggle<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1
nmap <silent> gc ,c<space>
vmap <silent> gc ,c<space>
nmap <silent> gm ,cm
vmap <silent> gm ,cm

" merlin
function! MerlinLocateMli()
   let g:merlin_locate_preference = 'mli'
   :MerlinLocate
   let g:merlin_locate_preference = 'ml'
endfunction
autocmd FileType ocaml nmap <silent> ,fg :MerlinLocate<cr>
autocmd FileType ocaml nmap <silent> ,fd :call MerlinLocateMli()<cr>
autocmd FileType ocaml nmap <silent> ,ft :MerlinTypeOf<cr>
autocmd FileType ocaml vmap <silent> ,ft :MerlinTypeOfSel<cr>
autocmd FileType ocaml nmap <silent> ,fy :MerlinYankLatestType<cr>

" tabularize
" map <leader>= and <leader>- to perform the most common alignments
vnoremap <leader>- :Tabularize /-><cr>
vnoremap <leader>; :Tabularize /^[^:]*\zs:<cr>
vnoremap <leader>= :Tabularize /^[^=]*\zs=<cr>

" limelight
" (assuming markdown only right now)
let g:limelight_bop = '^#'
let g:limelight_eop = '\ze\n^#'

" vim-ocaml
let g:ocaml_highlight_operators = 1

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

if has("gui_gtk")
  set guifont=Hack\ 10
else
  set guifont=Hack:h13
endif

" Some ocaml overrides, some attemts to make ALE more bearable
highlight! EnclosingExpr ctermbg=17 guibg=#2d362a
highlight! SpellBad cterm=italic ctermbg=NONE gui=undercurl guibg=NONE guisp=#cc6666
highlight! link Operator Keyword
highlight! link ocamlPpxIdentifier Keyword
highlight! link sexplibUnquotedAtom NONE

highlight! ALEError cterm=italic ctermbg=NONE gui=undercurl guibg=NONE guisp=#cc6666
highlight! link ALEStyleError   ALEError
highlight! link ALEWarning      ALEError
highlight! link ALEStyleWarning ALEError
highlight! link ALEInfo         ALEError


" vim-typescript looks upsettingly different from vim-javascript
highlight! link typescriptEndColons jsNoise
highlight! link typescriptOpSymbols jsOperator

set colorcolumn=81,121

augroup whitespace
  au!
  au InsertEnter * if exists('w:m_trailing') | try | call matchdelete(w:m_trailing) | finally | unlet w:m_trailing | endtry | endif
  au InsertLeave * if !exists('w:m_trailing') | let w:m_trailing=matchadd('Error', '\s\+$', -1) | endif
augroup end

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup end

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

function! ProfileStart()
  profile start vim-profile.log
  profile func *
  profile file *
endfunc
command! -nargs=0 ProfileStart :call ProfileStart()

function! ProfileStop()
  profile pause
  echo 'You must quit vim for profiling to be written to disk'
endfunc
command! -nargs=0 ProfileStop :call ProfileStop()

function! s:merlin_insert(lines)
  let s = matchstr(a:lines[0], '^\S*')
  call feedkeys("i" . s)
endfunction

function! Fzf_merlin()
  let start = merlin#Complete(1, "")
  let base = strpart(getline('.'), start, col('.') - 1 - start)
  let source = map(merlin#Complete(0, base), 'printf("%-25s %s", v:val.word, v:val.menu)')

  call fzf#run(fzf#wrap('merlin', {
        \ 'source': source,
        \ 'sink*': function('s:merlin_insert'),
        \ 'options': '+x -n 1,1..',
        \ }))
endfunction

function! Fzf_git_files()
  if empty($FZF_DEFAULT_COMMAND)
    let $FZF_DEFAULT_COMMAND='rg --files'
  endif

  if trim(system("git rev-parse --is-inside-work-tree")) == "true"
    " git-files defined in ~/bin/git-files
    "call s:merge_opts(args, get(g:, 'fzf_files_options', []))
    call fzf#run(fzf#vim#with_preview(fzf#wrap('git', {
          \ 'source': 'git files',
          \ 'options': '-m --prompt "git> "',
          \ })))
  else
    execute("FzfFiles")
  endif
endfunction

command! FzfGitFiles :call Fzf_git_files()
command! FzfMerlin :call Fzf_merlin()

" --- }}}

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
