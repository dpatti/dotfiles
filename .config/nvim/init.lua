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
-- plug
local vim_plug = vim.fn['plug#']
vim.fn['plug#begin'](vim.fn.stdpath('data') .. '/plug')

-- Languages
-- JavaScript
vim_plug('pangloss/vim-javascript')
vim_plug('kchmck/vim-coffee-script')
vim_plug('burnettk/vim-angular')
vim_plug('flowtype/vim-flow')
vim_plug('MaxMEllon/vim-jsx-pretty')
vim_plug('raichoo/purescript-vim')
vim_plug('FrigoEU/psc-ide-vim')
-- Ruby
vim_plug('tpope/vim-rails')
vim_plug('vim-ruby/vim-ruby')
vim_plug('tpope/vim-bundler')
-- Haskell
vim_plug('neovimhaskell/haskell-vim')
-- Ocaml
vim_plug('ocaml/vim-ocaml')
vim_plug('ocaml/merlin', { rtp = 'vim/merlin' })
vim_plug('copy/deoplete-ocaml')
-- Misc
vim_plug('tpope/vim-git')
vim_plug('groenewege/vim-less')
vim_plug('tpope/vim-markdown')
vim_plug('juvenn/mustache.vim')
vim_plug('rodjek/vim-puppet')
vim_plug('othree/html5.vim')
vim_plug('cespare/vim-toml')
vim_plug('rust-lang/rust.vim')
vim_plug('887/cargo.vim')
vim_plug('imsnif/kdl.vim')

-- Tools
vim_plug('mhinz/vim-startify')
vim_plug('mileszs/ack.vim')
vim_plug('junegunn/fzf', { ['do'] = './install --bin' })
vim_plug('junegunn/fzf.vim')
vim_plug('tpope/vim-fugitive')
vim_plug('terryma/vim-multiple-cursors')
vim_plug('tpope/vim-surround')
vim_plug('Shougo/deoplete.nvim', { ['do'] = ':UpdateRemotePlugins' })
vim_plug('qpkorr/vim-bufkill')
vim_plug('tpope/vim-eunuch')
vim_plug('scrooloose/nerdcommenter')
vim_plug('tpope/vim-endwise')
vim_plug('rbong/vim-vertical')
vim_plug('shougo/vimproc.vim', { ['do'] = 'make' })
vim_plug('sjl/gundo.vim')
vim_plug('ConradIrwin/vim-bracketed-paste')
vim_plug('w0rp/ale')
vim_plug('kana/vim-altr')
vim_plug('godlygeek/tabular')
vim_plug('thaerkh/vim-workspace')
vim_plug('AndrewRadev/linediff.vim')
vim_plug('pixelastic/vim-undodir-tree')
vim_plug('tpope/vim-vinegar')
vim_plug('tpope/vim-repeat')

-- Visual
vim_plug('airblade/vim-gitgutter')
vim_plug('vim-airline/vim-airline')
vim_plug('vim-airline/vim-airline-themes')
vim_plug('chriskempson/base16-vim')
vim_plug('junegunn/goyo.vim')
vim_plug('junegunn/limelight.vim')
vim_plug('junegunn/rainbow_parentheses.vim')
vim.fn['plug#end']()

-- ale
vim.g.ale_floating_preview = 1
vim.g.ale_floating_window_border = { '│', '─', '╭', '╮', '╯', '╰' }
vim.g.ale_lint_on_text_changed = 'normal'
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_linters = {
  haskell = { 'hie', 'hlint', 'hdevtools', 'stack-build' },
  ocaml = { 'merlin' },
  rust = { 'cargo', 'analyzer' },
}
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = {
  ocaml = { 'ocamlformat' },
  javascript = { 'prettier' },
  javascriptreact = { 'prettier' },
  json = { 'prettier' },
  typescript = { 'prettier' },
  typescriptreact = { 'prettier' },
  rust = { 'rustfmt' },
}
vim.keymap.set('n', ',ft', '<cmd>ALEHover<cr>', { silent = true })
vim.keymap.set('n', ',fg', '<cmd>ALEGoToDefinition<cr>', { silent = true })
vim.keymap.set('n', ',fd', '<cmd>ALEGoToTypeDefinition<cr>', { silent = true })
vim.keymap.set('n', ',fn', '<cmd>ALENextWrap<cr>', { silent = true })
vim.keymap.set('n', ',fe', '<cmd>ALEDetail<cr>', { silent = true })

-- linediff
vim.keymap.set('n', ',dm', '<cmd>LinediffMerge<CR>', { silent = true })
vim.keymap.set('n', ',dk', '<cmd>LinediffPick<CR>', { silent = true })
vim.keymap.set('n', ',dr', '<cmd>LinediffReset<CR>', { silent = true })
vim.keymap.set('v', ',da', '<cmd>LinediffAdd<CR>', { silent = true })
vim.keymap.set('v', ',db', '<cmd>LinediffLast<CR>', { silent = true })

-- startify
vim.g.startify_list_order = {
  { 'Most recently used' },
  'dir',
  { 'Bookmarks' },
  'bookmarks',
  { 'Sessions' },
  'sessions',
  { 'Commands' },
  'commands',
}
vim.g.startify_commands = {
  { l = { 'project tree', 'e .' } }
}
vim.g.startify_custom_header = { vim.fn.getcwd() }
vim.g.startify_change_to_dir = 0
vim.keymap.set('n', '~', '<cmd>Startify<CR>', { silent = true })

-- vim-altr
vim.keymap.set('n', '<leader>a', '<Plug>(altr-forward)')
vim.fn['altr#define']('%/%.ml', '%/%.mli', '%/%_intf.ml', '%/%0.ml', '%/%0.mli', '%/%1.ml', '%/%1.mli', '%/%.mly')

-- vim-javascript
vim.g.javascript_plugin_flow = 1

-- vim-ruby
vim.g.ruby_no_expensive = 1

-- ack
vim.cmd.cnoreabbrev('A', 'Ack!')
vim.keymap.set('n', '<C-A>', '<cmd>Ack!<CR>', { silent = true })
if vim.fn.executable('rg') == 1 then
  vim.g.ackprg = 'rg --vimgrep'
end

-- coffee-script
vim.api.nvim_create_user_command('CC', '<line1>,<line2>CoffeeCompile', { range = '%' })

-- git gutter
vim.g.gitgutter_realtime = 0
vim.g.gitgutter_map_keys = 0
vim.keymap.set('n', ',m', '<cmd>GitGutterNextHunk<CR>', { silent = true })
vim.keymap.set('n', ',M', '<cmd>GitGutterPrevHunk<CR>', { silent = true })

-- Powerline
vim.g.airline_section_y = '0x%02B'
vim.g.airline_theme = 'base16_tomorrow'
vim.g.airline_powerline_fonts = 0
vim.g.airline_skip_empty_sections = 1
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
if not vim.g.airline_symbols then
  vim.g.airline_symbols = {}
end
vim.g.airline_symbols = vim.tbl_extend('force', vim.g.airline_symbols, {
  branch = '',
  readonly = '',
})

-- Indent Guide
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_auto_colors = 0
vim.g.indent_guides_guide_size = 2
vim.api.nvim_set_hl(0, 'IndentGuidesOdd', { bg = '#1a1a1a' })
vim.api.nvim_set_hl(0, 'IndentGuidesEven', { bg = '#151515' })

-- fzf.vim
vim.g.fzf_command_prefix = 'Fzf'
vim.keymap.set('n', '<C-P>', '<cmd>FzfGitFiles<CR>', { silent = true })
vim.keymap.set('n', '<C-B>', '<cmd>FzfBuffers<CR>', { silent = true })
vim.keymap.set('n', '<C-T>', '<cmd>FzfMerlin<CR>', { silent = true })

-- deoplete
vim.api.nvim_create_autocmd({ 'InsertLeave', 'CompleteDone' }, {
  pattern = '*',
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd.pclose()
    end
  end,
})
vim.g['deoplete#enable_at_startup'] = 1
vim.g['deoplete#max_abbr_width'] = 0
vim.g['deoplete#max_menu_width'] = 0

vim.fn['deoplete#custom#option']('sources.ocaml', { 'ocaml', 'buffer', 'around', 'member', 'tag' })
vim.fn['deoplete#custom#source']('_', 'max_abbr_width', 0)
vim.fn['deoplete#custom#source']('_', 'max_menu_width', 0)

-- supertab
vim.g.SuperTabDefaultCompletionType = 'context'
vim.g.SuperTabContextDefaultCompletionType = '<c-n>'
vim.g.SuperTabLongestHighlight = 0

-- bufkill
vim.keymap.set('n', '<Leader>bd', '<cmd>BD<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bD', '<cmd>BD!<CR>', { silent = true })
vim.keymap.set('n', '<Leader>BD', '<cmd>BD!<CR>', { silent = true })

-- multiple-cursors
vim.g.multi_cursor_exit_from_visual_mode = 0
vim.g.multi_cursor_exit_from_insert_mode = 1

-- vim-vertical (overwrites C-K and C-J above)
vim.keymap.set('n', '<C-K>', '<cmd>Vertical b<CR>', { silent = true })
vim.keymap.set('n', '<C-J>', '<cmd>Vertical f<CR>', { silent = true })

-- vim-surround
vim.keymap.set('v', 's', 'S')

-- vim-flow
vim.g['flow#flowpath'] = 'node_modules/.bin/flow'

-- psc-ide-vim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'purescript',
  callback = function()
    vim.keymap.set('n', ',ft', '<cmd>PSCIDEtype<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fg', '<cmd>PSCIDEgoToDefinition<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fi', '<cmd>PSCIDEimportIdentifier<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fa', '<cmd>PSCIDEaddTypeAnnotation<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fs', '<cmd>PSCIDEapplySuggestion<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fr', '<cmd>PSCIDEload<cr>', { buffer = true, silent = true })
  end,
})

-- vim-workspace
vim.g.workspace_session_name = '.session.vim'
vim.g.workspace_autosave = 0
vim.g.workspace_autosave_untrailspaces = 0

-- gundo
if vim.fn.has('python3') == 1 then
  vim.g.gundo_prefer_python3 = 1
end
vim.keymap.set('n', ',gt', '<cmd>GundoToggle<CR>', { silent = true })

-- nerdcommenter
vim.g.NERDSpaceDelims = 1
vim.keymap.set('n', 'gc', ',c<space>', { silent = true, remap = true })
vim.keymap.set('v', 'gc', ',c<space>', { silent = true, remap = true })
vim.keymap.set('n', 'gm', ',cm', { silent = true, remap = true })
vim.keymap.set('v', 'gm', ',cm', { silent = true, remap = true })

-- merlin
local function merlin_locate_mli()
  vim.g.merlin_locate_preference = 'mli'
  vim.cmd.MerlinLocate()
  vim.g.merlin_locate_preference = 'ml'
end
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ocaml',
  callback = function()
    vim.keymap.set('n', ',fg', '<cmd>MerlinLocate<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fd', merlin_locate_mli, { buffer = true, silent = true })
    vim.keymap.set('n', ',ft', '<cmd>MerlinTypeOf<cr>', { buffer = true, silent = true })
    vim.keymap.set('v', ',ft', '<cmd>MerlinTypeOfSel<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fy', '<cmd>MerlinYankLatestType<cr>', { buffer = true, silent = true })
  end,
})

-- tabularize
vim.keymap.set('v', '<leader>-', ':Tabularize /-><cr>')
vim.keymap.set('v', '<leader>;', ':Tabularize /^[^:]*\\zs:<cr>')
vim.keymap.set('v', '<leader>=', ':Tabularize /^[^=]*\\zs=<cr>')

-- limelight
vim.g.limelight_bop = '^#'
vim.g.limelight_eop = '\\ze\\n^#'

-- vim-ocaml
vim.g.ocaml_highlight_operators = 1
-- --- }}}

-- --- Style and font --------------------------------------------------------{{{
vim.opt.background = "dark"
vim.g.base16colorspace = 256
vim.cmd.colorscheme('base16-tomorrow-night')

-- Some ocaml overrides, some attemts to make ALE more bearable
vim.api.nvim_set_hl(0, 'EnclosingExpr', { ctermbg = 17, bg = '#2d362a' })
vim.api.nvim_set_hl(0, 'SpellBad', { italic = true, undercurl = true, bg = 'NONE', sp = '#cc6666' })
vim.api.nvim_set_hl(0, 'Operator', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'ocamlPpxIdentifier', { link = 'Keyword' })
vim.api.nvim_set_hl(0, 'sexplibUnquotedAtom', {})

vim.api.nvim_set_hl(0, 'ALEError', { italic = true, undercurl = true, bg = 'NONE', sp = '#cc6666' })
vim.api.nvim_set_hl(0, 'ALEStyleError', { link = 'ALEError' })
vim.api.nvim_set_hl(0, 'ALEWarning', { link = 'ALEError' })
vim.api.nvim_set_hl(0, 'ALEStyleWarning', { link = 'ALEError' })
vim.api.nvim_set_hl(0, 'ALEInfo', { link = 'ALEError' })

-- vim-typescript looks upsettingly different from vim-javascript
vim.api.nvim_set_hl(0, 'typescriptEndColons', { link = 'jsNoise' })
vim.api.nvim_set_hl(0, 'typescriptOpSymbols', { link = 'jsOperator' })

vim.opt.colorcolumn = { 81, 121 }

vim.opt.list = true
do
  local group = vim.api.nvim_create_augroup('whitespace', { clear = true })
  vim.api.nvim_create_autocmd('InsertEnter', {
    group = group,
    callback = function() vim.opt_local.list = false end,
  })
  vim.api.nvim_create_autocmd('InsertLeave', {
    group = group,
    callback = function() vim.opt_local.list = true end,
  })
end

do
  local group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
  vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = group,
    pattern = '*',
    callback = function()
      vim.opt_local.cursorline = true
    end,
  })
  vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    group = group,
    pattern = '*',
    callback = function()
      vim.opt_local.cursorline = false
    end,
  })
end

-- --- }}}

-- --- Custom commands -------------------------------------------------------{{{

-- fill rest of line with characters
local function fill_line(str)
  local tw = vim.bo.textwidth
  if tw == 0 then tw = 80 end
  -- strip trailing spaces first
  local line = vim.api.nvim_get_current_line()
  line = line:gsub('%s+$', '')
  -- calculate total number of 'str's to insert
  local reps = math.floor((tw - #line) / #str)
  -- insert them, if there's room (with a leading space)
  if reps > 0 then
    line = line .. ' ' .. str:rep(reps)
  end
  vim.api.nvim_set_current_line(line)
end
vim.keymap.set('n', ',cl', function() fill_line('-') end, { silent = true })

-- Open terminal at current location
vim.keymap.set('n', ',ct', function()
  if vim.fn.has('unix') == 1 then
    vim.fn.system("gnome-terminal --working-directory='" .. vim.fn.getcwd() .. "' &")
  end
end, { silent = true })

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
if vim.fn.exists(':DiffOrig') ~= 2 then
  vim.api.nvim_create_user_command('DiffOrig', function()
    vim.cmd('vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis')
  end, {})
end

-- Show syntax highlight groups under cursor
local function syn_stack()
  local stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
  local names = vim.tbl_map(function(id) return vim.fn.synIDattr(id, 'name') end, stack)
  print(vim.inspect(names))
end
vim.api.nvim_create_user_command('SynStack', syn_stack, {})

-- Profiling helpers
vim.api.nvim_create_user_command('ProfileStart', function()
  vim.cmd('profile start vim-profile.log')
  vim.cmd('profile func *')
  vim.cmd('profile file *')
end, {})

vim.api.nvim_create_user_command('ProfileStop', function()
  vim.cmd('profile pause')
  print('You must quit vim for profiling to be written to disk')
end, {})

-- fzf merlin completion
local function fzf_merlin()
  local start = vim.fn['merlin#Complete'](1, '')
  local base = vim.fn.strpart(vim.fn.getline('.'), start, vim.fn.col('.') - 1 - start)
  local completions = vim.fn['merlin#Complete'](0, base)
  local source = vim.tbl_map(function(v)
    return string.format('%-25s %s', v.word, v.menu)
  end, completions)

  vim.fn['fzf#run'](vim.fn['fzf#wrap']('merlin', {
    source = source,
    ['sink*'] = function(lines)
      local s = lines[1]:match('^%S*')
      vim.fn.feedkeys('i' .. s)
    end,
    options = '+x -n 1,1..',
  }))
end

-- fzf git files (with fallback)
local function fzf_git_files()
  if vim.env.FZF_DEFAULT_COMMAND == nil or vim.env.FZF_DEFAULT_COMMAND == '' then
    vim.env.FZF_DEFAULT_COMMAND = 'rg --files'
  end

  local is_git = vim.fn.trim(vim.fn.system('git rev-parse --is-inside-work-tree'))
  if is_git == 'true' then
    vim.fn['fzf#run'](vim.fn['fzf#vim#with_preview'](vim.fn['fzf#wrap']('git', {
      source = 'git files',
      options = '-m --prompt "git> "',
    })))
  else
    vim.cmd('FzfFiles')
  end
end

vim.api.nvim_create_user_command('FzfGitFiles', fzf_git_files, {})
vim.api.nvim_create_user_command('FzfMerlin', fzf_merlin, {})
-- --- }}}
