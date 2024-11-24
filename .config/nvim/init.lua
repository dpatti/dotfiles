-- --- Options ---------------------------------------------------------------{{{
vim.opt.swapfile = false         -- Do not use swap files
vim.opt.undofile = true
vim.opt.formatoptions = {
  c = true,  -- wrap comments at textwidth
  r = true,  -- insert comment leader
  o = true,
  q = true,
  l = true
}
vim.opt.textwidth = 80           -- 80 characters wide
vim.opt.showmode = false         -- Don't display current mode since it's in the status line

-- (ditch?)
-- vim.opt.cmdheight = 2            -- Command line two lines high

vim.opt.wildignorecase = true    -- Ignore case when tab-completing files
vim.opt.timeoutlen = 500         -- Timeout for remaps
vim.opt.ttimeoutlen = 10         -- Timeout for escape sequences
vim.opt.scrolloff = 8            -- Always keep cursor 8 lines from vertical edge
vim.opt.sidescrolloff = 3        -- Always keep cursor 3 lines from horizontal edge
vim.opt.virtualedit = 'all'      -- Allow the cursor to go to invalid places
vim.opt.cursorline = true        -- Highlight current line
vim.opt.wrap = false             -- Disable wrapping by default
vim.opt.linebreak = true         -- Try to break at a nice character
vim.opt.cpoptions:append('$')    -- Change commands will display a $ to mark end of changed text
vim.opt.ignorecase = true        -- Search will ignore case
vim.opt.smartcase = true         -- Search will respect case if any letter is uppercase
vim.opt.shortmess:append('c')    -- No completion menu errors as you're typing
vim.opt.pumheight = 10           -- Show no more than 10 items in the popup window

-- (revisit these?)
vim.opt.completeopt:append('menuone')  -- Show completion popup even if there is one suggestion
vim.opt.completeopt:append('noselect') -- Don't select, just pop up
vim.opt.completeopt:remove('preview')  -- Don't show preview window

-- (use list?)
vim.opt.listchars = { tab = '> ', trail = '-', extends = '>', precedes = '<', nbsp = '+' }

-- (ditch?)
-- vim.opt.shada:append('%')        -- save buffer list on exit

vim.opt.report = 0               -- report how many lines a : command changes

vim.opt.comments:remove({ n = '>' }) -- > is not a comment
vim.opt.comments:append({ b = '>' }) -- okay it kind of is, but only when there's a space after (i don't think 'n' works with 'b')

-- Tabs are 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- (ditch?)
-- vim.opt.foldopen:append({ 'insert', 'jump' })
vim.opt.foldmethod = 'marker'   -- Use {{{ }}} for folds

-- --- }}}

-- --- Mappings --------------------------------------------------------------{{{
vim.g.mapleader = ','       -- Set the <leader> key to comma

-- Moving between wrapped lines
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('n', 'j', 'gj', { silent = true })

-- Indent modification keeps visual mode
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('v', '<', '<gv', { silent = true })

-- Mappings for easy toggle between 2 and 4 depending on document (kill?)
vim.keymap.set('n', '<leader>2', '<cmd>set tabstop=2 softtabstop=2 shiftwidth=2<cr>')
vim.keymap.set('n', '<leader>4', '<cmd>set tabstop=4 softtabstop=4 shiftwidth=4<cr>')

-- Use Ctrl+C and Ctrl+V to copy/paste in their respective modes
if vim.fn.has('clipboard') == 1 then
  vim.keymap.set('v', '<C-X>', '"+x')
  vim.keymap.set('v', '<C-C>', '"+y')
  vim.keymap.set('i', '<C-V>', '<C-O>"+gP')
  vim.keymap.set('c', '<C-V>', '<C-R>+')
end

-- Remap the old C-V in insert mode (escape sequence)
vim.keymap.set('i', '<C-F>', '<C-V>')

-- Let's make it easy to edit/source this file ('e'dit 'v'imrc)
vim.keymap.set('n', '<leader>ev', '<cmd>edit $HOME/.config/nvim/init.lua<cr>', { silent = true })
vim.keymap.set('n', '<leader>sv', '<cmd>source $HOME/.config/nvim/init.lua<cr>', { silent = true })

-- Set text wrapping toggles
vim.keymap.set('n', '<leader>w', '<cmd>set invwrap<cr><cmd>set wrap?<cr>', { silent = true })

-- Toggle paste mode (ditch?)
-- vim.keymap.set('n', '<leader>p', '<cmd>set invpaste<cr><cmd>set paste?<cr>', { silent = true })

-- Toggle text wrap
vim.keymap.set('n', '<leader>t', [[<cmd>if stridx(&fo, 't') == -1 | set fo+=t | else | set fo-=t | endif<cr><cmd>set fo?<cr>]], { silent = true })

-- Turn off higlight search
vim.keymap.set('n', '<leader>n', '<cmd>set invhlsearch<cr><cmd>set hlsearch?<cr>', { silent = true })

-- cd to directory of file in buffer
vim.keymap.set('n', '<leader>cd', '<cmd>lcd %:h<cr>', { silent = true })

-- Move the cursor to different windows
vim.keymap.set('', '<leader>h', '<C-w><C-h>', { silent = true })
vim.keymap.set('', '<leader>j', '<C-w><C-j>', { silent = true })
vim.keymap.set('', '<leader>k', '<C-w><C-k>', { silent = true })
vim.keymap.set('', '<leader>l', '<C-w><C-l>', { silent = true })

-- Ctrl+Backspace to delete prev word (ditch?)
-- vim.keymap.set('i', '<C-BS>', '<C-W>')
-- vim.keymap.set('c', '<C-BS>', '<C-W>')

-- Diff (t)his, Diff (o)ff!
vim.keymap.set('n', '<leader>dt', '<cmd>difft<cr>', { silent = true })
vim.keymap.set('n', '<leader>do', '<cmd>diffo!<cr>', { silent = true })

-- Fold methods (ditch?)
-- vim.keymap.set('n', '<leader>fm', '<cmd>set foldmethod=marker<cr>', { silent = true })
-- vim.keymap.set('n', '<leader>fi', '<cmd>set foldmethod=indent<cr>', { silent = true })

-- lookup keyword is almost never used, invert J instead
vim.keymap.set('n', 'K', 'i<CR><Esc>k$')

-- Slide cursor to the next/previous line of the same indent level (ditch?) (vim-vertical?)
-- vim.keymap.set('n', '<C-K>', [[<cmd>call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>]], { silent = true })
-- vim.keymap.set('n', '<C-J>', [[<cmd>call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>]], { silent = true })

-- Tabs (ditch?)
-- vim.keymap.set('n', '<A-[>', '<cmd>tabprevious<CR>', { silent = true })
-- vim.keymap.set('n', '<A-]>', '<cmd>tabnext<CR>', { silent = true })

-- Command abbreviations (ditch?)
-- vim.cmd.cnoreabbrev('CWD', '%:h')

-- --- }}}

-- --- Plugin config ---------------------------------------------------------{{{
vim.cmd [=[
" plug
call plug#begin(stdpath('data') . '/plug')

" Languages
" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'burnettk/vim-angular'
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
Plug '887/cargo.vim'

" Tools
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
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
      \ 'rust': ['cargo', 'analyzer'],
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
nmap <silent> ,fe :ALEDetail<cr>

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
      \ check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ check_back_space() ? "\<S-TAB>" :
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
]=]
-- --- }}}

-- --- Style and font --------------------------------------------------------{{{
vim.opt.background = "dark"
vim.g.base16colorspace = 256
vim.cmd.colorscheme('base16-tomorrow-night')

-- Some ocaml overrides, some attemts to make ALE more bearable
vim.cmd.highlight { [[EnclosingExpr ctermbg=17 guibg=#2d362a]], bang = true }
vim.cmd.highlight { [[SpellBad cterm=italic ctermbg=NONE gui=undercurl guibg=NONE guisp=#cc6666]], bang = true }
vim.cmd.highlight { [[link Operator Keyword]], bang = true }
vim.cmd.highlight { [[link ocamlPpxIdentifier Keyword]], bang = true }
vim.cmd.highlight { [[link sexplibUnquotedAtom NONE]], bang = true }

vim.cmd.highlight { [[ALEError cterm=italic ctermbg=NONE gui=undercurl guibg=NONE guisp=#cc6666]], bang = true }
vim.cmd.highlight { [[link ALEStyleError   ALEError]], bang = true }
vim.cmd.highlight { [[link ALEWarning      ALEError]], bang = true }
vim.cmd.highlight { [[link ALEStyleWarning ALEError]], bang = true }
vim.cmd.highlight { [[link ALEInfo         ALEError]], bang = true }

-- vim-typescript looks upsettingly different from vim-javascript
vim.cmd.highlight { [[link typescriptEndColons jsNoise]], bang = true }
vim.cmd.highlight { [[link typescriptOpSymbols jsOperator]], bang = true }

vim.opt.colorcolumn = { 81, 121 }

-- (probably replace with :list?)
do
  local group = vim.api.nvim_create_augroup('whitespace', { clear = true })
  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    group = group,
    pattern = '*',
    command = [[if exists('w:m_trailing') | try | call matchdelete(w:m_trailing) | finally | unlet w:m_trailing | endtry | endif]],
  })
  vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    group = group,
    pattern = '*',
    command = [[if !exists('w:m_trailing') | let w:m_trailing=matchadd('Error', '\s\+$', -1) | endif]],
  })
end

do
  local group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
  vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = group,
    pattern = '*',
    command = [[setlocal cursorline]],
  })
  vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    group = group,
    pattern = '*',
    command = [[setlocal nocursorline]],
  })
end

-- --- }}}

-- --- Custom commands -------------------------------------------------------{{{
vim.cmd [=[
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
]=]
-- --- }}}
