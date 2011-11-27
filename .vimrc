set nocompatible

" Forget being compatible with good ol' vi
set nocompatible

" File format prefer unix endings
set ffs=unix,dos

" Format options
set formatoptions=crq
set textwidth=80

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Turn on syntax highlighting
syntax on

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Don't update the display while executing macros
" set lazydraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu. See :help 'wildmenu'
set wildmenu

" Set our <Leader> key
let mapleader=","

" Let's make it easy to edit/source this file ('e'dit 'v'imrc)
nmap <silent> ,ev :e $HOME/.vimrc<cr>
nmap <silent> ,sv :so $HOME/.vimrc<cr>

" Set text wrapping toggles
nmap <silent> ,w :set invwrap<cr>:set wrap?<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<cr>:set paste?<cr>

" Turn off higlight search
nmap <silent> ,n :set invhls<cr>:set hls?<cr>

" cd to directory of file in buffer
nmap <silent> ,cd :lcd %:h<cr>

" Move the cursor to different windows
noremap <silent> ,h :wincmd h<cr>
noremap <silent> ,j :wincmd j<cr>
noremap <silent> ,k :wincmd k<cr>
noremap <silent> ,l :wincmd l<cr>

" Ctrl+Backspace to delete prev word
imap <C-BS> <C-W>

" Change Y to be more consistent with C, D, etc.
map Y y$

" Close current window, aka "c-w c"
" noremap <silent> ,cc :close<cr>

" Tabstops are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" No wrapping
set nowrap

" set the search scan to wrap lines
set wrapscan

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note. Backslashes suck
set shellslash

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allowing backspacing over indent, eol, and the start of an insert
set backspace=2

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions+=$

" Set the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" tell Vim to always put a status line in
set laststatus=2

" Hide the mouse pointer while typing
set mousehide

" Timeout for remaps
set timeoutlen=500

" Keep some stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker

" When the page starts to scroll, keep the cursor 8 lines from the edge
set scrolloff=8

" Allow the cursor to go to invalid places
set virtualedit=all

" Might include later?
" set complete=.,w,b,t

" Incrementally match the search
set incsearch

" Don't color long lines
set synmaxcol=1024

" Moving between wrapped lines
nnoremap k gk
nnoremap j gj

" Style
colorscheme railscasts
highlight Comment     guifg=#656763 ctermfg=180 gui=italic
highlight NonText     guifg=#656763	ctermfg=180
highlight Pmenu       guifg=#656763 guibg=#ffffff
highlight PmenuSel    guifg=#656763 guibg=#ffffff
highlight PmenuSbar   guifg=#656763 guibg=#ffffff
highlight PmenuThumb  guifg=#656763 guibg=#ffffff
highlight Folded      guifg=#ffffff guibg=#555555
set cul

" Font
set guifont=Consolas:h10

" No backup files
set nobk

" .ntl, .ntj files are really JavaScript
autocmd BufNewFile,BufRead *.ntl setfiletype javascript
autocmd BufNewFile,BufRead *.ntj setfiletype javascript

" C function carpet bomb
" %s/\(.* \)\(\S*\)\((.*\n{\)/\1\2\3\r  printf("\2\\n");/g

" pathogen
call pathogen#runtime_append_all_bundles()

" ctags
set tags+=$VIM/tags/cpp
set tags+=$VIM/tags/bwapi
map <silent> <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" " OmniCpp
" let OmniCpp_NamespaceSearch = 1
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_ShowAccess = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" let OmniCpp_MayCompleteDot = 1 " autocomplete after .
" let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
" let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "BWAPI"]
" " automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest,preview

" SuperTab
" let SuperTabDefaultCompletionType = "<C-X><C-O>"
" let SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
" let SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" let SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]


" FSwitch
nmap <silent> ,fs :FSHere<CR>
nmap <silent> ,fp :FSSplitRight<CR>
nmap <silent> ,fh :FSLeft<CR>
nmap <silent> ,fl :FSRight<CR>

" xptemplate
" let xptemplate_pum_tab_nav=1
" let xptemplate_vars="SParg="
" let xptemplate_key="<C-Tab>"

" NERD Tree Plugin
nmap <F7> :NERDTreeToggle<CR>

" Lua Globals - my failed attempt
highlight Global guifg=#3B3178
function! LuaGlob()
	call clearmatches()
	let globals = system("luac -l \"" . expand("%:p") . "\" | grep GLOBAL | sed 's/.* \\(.*\\)$/\\1/' | sort | uniq")
	for kw in split(globals)
		call matchadd("Global", kw)
	endfor
endfunction
" FindGlobals (globals.lua)
function! LuaGlob()
	let file = expand("%:p")
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	" echo "$read !luac -l -p \"" . file . "\" | lua C:\\Lua\\5.1\\globals.lua \"" . file . "\""
	silent execute "$read !luac -l -p \"" . file . "\" | lua C:\\Lua\\5.1\\globals.lua \"" . file . "\""
	setlocal nomodifiable
endfunction
nmap <silent> ,gl :call LuaGlob()<cr>

" Combat Log fix for 4.2
function! FixCombatLog()
	execute '%s/^\([^,]*,[^,]*,[^,]*,[^,]*,\)[^,]*,\([^,]*,[^,]*,[^,]*\),[^,]*\(.*\)/\1\2\3/g'
endfunction

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

" A map for the commonly used %s/\(.*\)/...
function! Wrap(start, end, replace)
	echo start
	echo end
	echo replace
endfunction
command! -range=% -nargs=1 Wrap call <SID>Wrap('<line1>', '<line2>', '<args>')

" Create a symlink for Windows
function! Symlink()
    " Need to separate these to force \ in path
    execute "!mklink /J " . substitute(expand("$HOME\\vimfiles $HOME\\.vim"), "/", "\\", "g")
endfunction
command! Sym call Symlink()

" This was here; I don't know what it does
set diffexpr=MyDiff()
function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else

	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
