" My .vimrc file

" --- Options ---------------------------------------------------------------{{{
set nocompatible        " Disable vi compatability
set ffs=unix,dos        " File format prefer unix endings
set eol                 " Add newline at end of file
set shellslash          " Use forward slashes for file names
set vb                  " Visual bell instead of beep
set nobk                " Do not use backup files
set formatoptions=crq   " Format options: wrap (c)omments at textwidth, insert comment leade(r), and unknown
set textwidth=80        " 80 characters wide
set hidden              " Allow unsaved buffers to be hidden
set laststatus=2        " Always use status line
set showmode            " Display current mode
set ch=2                " Command line two lines high
set wildmenu            " Command line completion helper
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
set wrapscan            " Search will continue past end of document
set incsearch           " Search as you type
set ignorecase          " Search will ignore case
set smartcase           " Search will respect case if any letter is uppercase
syntax on               " Turn on syntax highlighting

" Tabstops are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Set the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker   " Use {{{ }}} for folds

" Filetype specific stuff
filetype on
filetype plugin on
filetype indent on
" --- }}}

" --- Mappings --------------------------------------------------------------{{{
let mapleader=","       " Set the <Leader> key to comma

" Moving between wrapped lines
nnoremap k gk
nnoremap j gj

" Indent modification keeps visual mode
vnoremap > >gv
vnoremap < <gv

" Let's make it easy to edit/source this file ('e'dit 'v'imrc)
nmap <silent> ,ev :e $HOME/.vimrc<cr>
nmap <silent> ,sv :so $HOME/.vimrc<cr>

" Set text wrapping toggles
nmap <silent> ,w :set invwrap<cr>:set wrap?<cr>

" Toggle paste mode -- I don't know what this is yet
" nmap <silent> ,p :set invpaste<cr>:set paste?<cr>

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

" Session management
map <F2> :mksession! ~/vim_session <cr>
map <F3> :source ~/vim_session <cr>

" Diff (t)his, Diff (o)ff!
nmap <silent> ,dt :difft<cr>
nmap <silent> ,do :diffo!<cr>:set nowrap<cr>:set foldmethod=marker<cr>

" Fold methods
nmap <silent> ,fm :set foldmethod=marker<cr>
nmap <silent> ,fi :set foldmethod=indent<cr>
" --- }}}

" --- Style and font --------------------------------------------------------{{{
colorscheme railscasts
highlight Comment     guifg=#656763 ctermfg=180 gui=italic
highlight NonText     guifg=#656763	ctermfg=180
highlight Pmenu       guifg=#656763 guibg=#ffffff
highlight PmenuSel    guifg=#656763 guibg=#ffffff
highlight PmenuSbar   guifg=#656763 guibg=#ffffff
highlight PmenuThumb  guifg=#656763 guibg=#ffffff
highlight Folded      guifg=#ffffff guibg=#555555
set guifont=Consolas:h10
" --- }}}

" --- Plugin config ---------------------------------------------------------{{{
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
" --- }}}

" --- Custom commands -------------------------------------------------------{{{
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
" Not working yet
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

" Open terminal at current location
function! Terminal()
    " Currently only for windows
    execute "!start C:\\cygwin\\bin\\mintty.exe -e /bin/xhere /bin/bash.exe '" . getcwd() . "'"
endfunction
nmap <silent> ,ct :call Terminal()<cr>

" This was here; I don't know what it does
" set diffexpr=MyDiff()
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
" --- }}}

" --- Miscellaneous ---------------------------------------------------------{{{
" .ntl, .ntj files are really JavaScript
augroup d2botType
    autocmd!
    autocmd BufNewFile,BufRead *.ntl setfiletype javascript
    autocmd BufNewFile,BufRead *.ntj setfiletype javascript
augroup END

" Change permissions on new files to be 0644 in cygwin
" TODO make windows only
augroup filePerms
    autocmd!
    " autocmd BufWritePre * call NewFileTest()
augroup END
function! NewFileTest()
    if !filereadable(expand('<afile>'))
        " If the file cannot be found pre-write, add a post-write command
        autocmd filePerms BufWritePost * call FileNoExec()
    else
        " If it is already there, check the flags and call if it isn't executable now
        let cygpath = system("C:\\cygwin\\bin\\cygpath.exe " . expand("<afile>"))
        echo cygpath
        let flags = system("C:\\cygwin\\bin\\run.exe /usr/bin/stat --printf=%A " . cygpath)
        echo flags . "!!"
        if substitute(flags, "[^x]", "", "g") == ""
            " This should not be flagged executable
            autocmd filePerms BufWritePost * call FileNoExec()
        endif
    endif
endfunction
function! FileNoExec()
    " Remove command after it is executed once
    autocmd! filePerms BufWritePost
    " Get the path of the current file in cygwin terms
    let cygpath = system("C:\\cygwin\\bin\\cygpath.exe " . expand("<afile>"))
    " Change permissions
    execute "!start C:\\cygwin\\bin\\run.exe /usr/bin/chmod -x \"" . cygpath . "\" 2>> ~/.vim/error"
endfunction


" C function carpet bomb
" %s/\(.* \)\(\S*\)\((.*\n{\)/\1\2\3\r  printf("\2\\n");/g
" --- }}}
