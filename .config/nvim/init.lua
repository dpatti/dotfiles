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

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.report = 0               -- report how many lines a : command changes

vim.opt.comments:remove({ n = '>' }) -- > is not a comment
vim.opt.comments:append({ b = '>' }) -- okay it kind of is, but only when there's a space after (i don't think 'n' works with 'b')

-- Tabs are 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.foldmethod = 'marker'   -- Use {{{ }}} for folds

-- --- }}}

-- --- Mappings --------------------------------------------------------------{{{
vim.g.mapleader = ','       -- Set the <leader> key to comma

vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Moving between wrapped lines
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('n', 'j', 'gj', { silent = true })

-- Indent modification keeps visual mode
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('v', '<', '<gv', { silent = true })

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

-- Toggle text wrap
vim.keymap.set('n', '<leader>t', [[<cmd>if stridx(&fo, 't') == -1 | set fo+=t | else | set fo-=t | endif<cr><cmd>set fo?<cr>]], { silent = true })

-- cd to directory of file in buffer
vim.keymap.set('n', '<leader>cd', '<cmd>lcd %:h<cr>', { silent = true })

-- Move the cursor to different windows
vim.keymap.set('', '<leader>h', '<C-w><C-h>', { silent = true })
vim.keymap.set('', '<leader>j', '<C-w><C-j>', { silent = true })
vim.keymap.set('', '<leader>k', '<C-w><C-k>', { silent = true })
vim.keymap.set('', '<leader>l', '<C-w><C-l>', { silent = true })

-- Diff (t)his, Diff (o)ff!
vim.keymap.set('n', '<leader>dt', '<cmd>difft<cr>', { silent = true })
vim.keymap.set('n', '<leader>do', '<cmd>diffo!<cr>', { silent = true })

-- lookup keyword is almost never used, invert J instead
vim.keymap.set('n', 'K', 'i<CR><Esc>k$')

-- --- }}}

-- --- Plugin config ---------------------------------------------------------{{{

-- See ~/.bootstrap/nvim
require('mini.deps').setup({ path = { package = vim.fn.stdpath('data') .. '/site/' }})

-- (use now/later?)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local never = function(_) end
add({ name = 'mini.nvim', checkout = 'stable' })

require('mini.base16').setup({
  palette = {
    base00 = '#1d1f21',
    base01 = '#282a2e',
    base02 = '#373b41',
    base03 = '#969896',
    base04 = '#b4b7b4',
    base05 = '#c5c8c6',
    base06 = '#e0e0e0',
    base07 = '#ffffff',
    base08 = '#cc6666',
    base09 = '#de935f',
    base0A = '#f0c674',
    base0B = '#b5bd68',
    base0C = '#8abeb7',
    base0D = '#81a2be',
    base0E = '#b294bb',
    base0F = '#a3685a',
  },
  use_cterm = false,
  plugins = { default = true }
})

require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()

require('mini.cmdline').setup()
require('mini.statusline').setup()
-- require('mini.completion').setup()

-- (disable virtual_text until I figure out the lua warning thing? (it doesn't
-- work?))
vim.diagnostic.config({ virtual_text = false })

vim.keymap.set('n', ',fn', function() vim.diagnostic.jump({ count = 1, wrap = true, float = true }) end, { desc = '[N]ext error' })
vim.keymap.set('n', ',ff', function() vim.lsp.buf.format() end, { desc = '[F]ormat' })

-- lsp
do
  add('neovim/nvim-lspconfig')
  vim.lsp.enable('ts_ls')

  -- (still has lots of undefined-global diagnostic warnings?)
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            '?.lua',
            '?/init.lua',
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      },
    },
  })
  vim.lsp.enable('lua_ls')
end

-- treesitter
later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  -- :lua= require('nvim-treesitter').get_available()
  local filetypes = {
    'asm',
    'awk',
    'bash',
    'bpftrace',
    'c',
    'cmake',
    'commonlisp',
    'cpp',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'dot',
    'fish',
    'go',
    'haskell',
    'html',
    'javascript',
    'jsonnet',
    'jsx',
    'kdl',
    'lua',
    'make',
    'markdown',
    'nginx',
    'nix',
    'ocaml',
    'python',
    'ruby',
    'rust',
    'sql',
    'strace',
    'tmux',
    'toml',
    'tsx',
    'typescript',
    'xml',
    'xresources',
    'yaml',
    'zig',
    'zsh',
  }
  require('nvim-treesitter').install(filetypes)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function() vim.treesitter.start() end,
  })
end)

-- picker
later(function()
  add('folke/snacks.nvim')
  require('snacks').setup({
    picker = {
      matcher = {
        frecency = true,
      },
      ui_select = true,
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" }, desc = "Close" },
            ["<C-u>"] = { "<C-u>", mode = { "i" }, expr = true, desc = "Kill line" },
          },
        },
      },
    },
  })

  vim.keymap.set('n', '<leader>sp', Snacks.picker.pickers, { desc = '[S]earch [P]ickers' })
  vim.keymap.set('n', '<leader>sh', Snacks.picker.help, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', Snacks.picker.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', Snacks.picker.files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sw', Snacks.picker.grep_word, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', Snacks.picker.grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', Snacks.picker.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', Snacks.picker.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', Snacks.picker.recent, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', Snacks.picker.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader>sb', Snacks.picker.buffers, { desc = '[S]earch [B]uffers' })

  vim.keymap.set('n', '<C-A>', Snacks.picker.grep_word, { desc = 'Search current word' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      vim.keymap.set('n', 'grr', Snacks.picker.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
      vim.keymap.set('n', 'gri', Snacks.picker.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', 'grd', Snacks.picker.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gO', Snacks.picker.lsp_symbols, { buffer = buf, desc = 'Open Document Symbols' })
      vim.keymap.set('n', 'gW', Snacks.picker.lsp_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
      vim.keymap.set('n', 'grt', Snacks.picker.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })

      -- The ones I'm used to
      vim.keymap.set('n', ',fo', Snacks.picker.lsp_references, { buffer = buf, desc = 'Goto References' })
      vim.keymap.set('n', ',fi', Snacks.picker.lsp_implementations, { buffer = buf, desc = 'Goto Implementation' })
      vim.keymap.set('n', ',fg', Snacks.picker.lsp_definitions, { buffer = buf, desc = 'Goto Definition' })
      vim.keymap.set('n', ',fd', Snacks.picker.lsp_declarations, { buffer = buf, desc = 'Goto Declaration' })
      vim.keymap.set('n', ',fr', Snacks.picker.lsp_type_definitions, { buffer = buf, desc = 'Goto Type Definition' })
    end,
  })
end)

-- completion
later(function()
  add('saghen/blink.cmp')
  require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },
    -- (switch to rust impl?)
    fuzzy = { implementation = "lua" },
  })
end)

-- Languages
add('pangloss/vim-javascript')
add('MaxMEllon/vim-jsx-pretty')
add('tpope/vim-git')
add('groenewege/vim-less')
add('tpope/vim-markdown')
add('cespare/vim-toml')
add('rust-lang/rust.vim')
add('887/cargo.vim')
add('imsnif/kdl.vim')

-- Tools
add('tpope/vim-fugitive')
add('tpope/vim-eunuch')
add('tpope/vim-endwise')
add('ConradIrwin/vim-bracketed-paste')
add('pixelastic/vim-undodir-tree')
add('tpope/vim-vinegar')
add('tpope/vim-repeat')

-- Visual
add('junegunn/goyo.vim')
add('junegunn/rainbow_parentheses.vim')

-- vim-ocaml
add('ocaml/vim-ocaml')
vim.g.ocaml_highlight_operators = 1

-- ale
add('w0rp/ale')
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
-- vim.keymap.set('n', ',ft', '<cmd>ALEHover<cr>', { silent = true })
-- vim.keymap.set('n', ',fg', '<cmd>ALEGoToDefinition<cr>', { silent = true })
-- vim.keymap.set('n', ',fd', '<cmd>ALEGoToTypeDefinition<cr>', { silent = true })
-- vim.keymap.set('n', ',fn', '<cmd>ALENextWrap<cr>', { silent = true })
-- vim.keymap.set('n', ',fe', '<cmd>ALEDetail<cr>', { silent = true })

-- linediff
add('AndrewRadev/linediff.vim')
vim.keymap.set('n', ',dm', '<cmd>LinediffMerge<CR>', { silent = true })
vim.keymap.set('n', ',dk', '<cmd>LinediffPick<CR>', { silent = true })
vim.keymap.set('n', ',dr', '<cmd>LinediffReset<CR>', { silent = true })
vim.keymap.set('v', ',da', '<cmd>LinediffAdd<CR>', { silent = true })
vim.keymap.set('v', ',db', '<cmd>LinediffLast<CR>', { silent = true })

-- startify
add('mhinz/vim-startify')
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
add('kana/vim-altr')
vim.keymap.set('n', '<leader>a', '<Plug>(altr-forward)')
vim.fn['altr#define']('%/%.ml', '%/%.mli', '%/%_intf.ml', '%/%0.ml', '%/%0.mli', '%/%1.ml', '%/%1.mli', '%/%.mly')

-- ack
add('mileszs/ack.vim')
vim.g.ackprg = 'rg --vimgrep'
vim.api.nvim_create_user_command('A', function(args)
  vim.cmd('Ack!', args)
end, { nargs = '*', complete = 'file' })
vim.keymap.set('n', '<C-A>', '<cmd>call histadd("cmd", "A " . expand("<cword>"))<CR>:A<CR>', { silent = true })

-- git gutter
add('airblade/vim-gitgutter')
vim.g.gitgutter_realtime = 0
vim.g.gitgutter_map_keys = 0
vim.keymap.set('n', ',m', '<cmd>GitGutterNextHunk<CR>', { silent = true })
vim.keymap.set('n', ',M', '<cmd>GitGutterPrevHunk<CR>', { silent = true })

-- fzf.vim
vim.g.fzf_vim = { command_prefix = 'Fzf' }
add({
  source = 'junegunn/fzf.vim',
  depends = { 'junegunn/fzf' },
})
vim.keymap.set('n', '<C-_>', '<cmd>FzfRg<CR>', { silent = true }) -- Ctrl+/
vim.keymap.set('n', '<C-P>', '<cmd>FzfGitFiles<CR>', { silent = true })
vim.keymap.set('n', '<C-B>', '<cmd>FzfBuffers<CR>', { silent = true })
vim.keymap.set('n', '<C-T>', '<cmd>FzfMerlin<CR>', { silent = true })

-- bufkill
add('qpkorr/vim-bufkill')
vim.keymap.set('n', '<Leader>bd', '<cmd>BD<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bD', '<cmd>BD!<CR>', { silent = true })
vim.keymap.set('n', '<Leader>BD', '<cmd>BD!<CR>', { silent = true })

-- multiple-cursors
add('terryma/vim-multiple-cursors')
vim.g.multi_cursor_exit_from_visual_mode = 0
vim.g.multi_cursor_exit_from_insert_mode = 1

-- vim-vertical (overwrites C-K and C-J above)
add('rbong/vim-vertical')
vim.keymap.set('n', '<C-K>', '<cmd>Vertical b<CR>', { silent = true })
vim.keymap.set('n', '<C-J>', '<cmd>Vertical f<CR>', { silent = true })

-- vim-surround
add('tpope/vim-surround')
vim.keymap.set('v', 's', '<plug>VSurround')

-- vim-workspace
add('thaerkh/vim-workspace')
vim.g.workspace_session_name = '.session.vim'
vim.g.workspace_autosave = 0
vim.g.workspace_autosave_untrailspaces = 0

-- gundo
add('sjl/gundo.vim')
vim.g.gundo_prefer_python3 = 1
vim.keymap.set('n', ',gt', '<cmd>GundoToggle<CR>', { silent = true })

-- nerdcommenter
add('scrooloose/nerdcommenter')
vim.g.NERDSpaceDelims = 1
vim.keymap.set('n', 'gc', ',c<space>', { silent = true, remap = true })
vim.keymap.set('v', 'gc', ',c<space>', { silent = true, remap = true })
vim.keymap.set('n', 'gm', ',cm', { silent = true, remap = true })
vim.keymap.set('v', 'gm', ',cm', { silent = true, remap = true })

-- (reintroduce or kill?)
-- merlin
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ocaml',
  callback = function()
    vim.keymap.set('n', ',fg', '<cmd>MerlinLocateImpl<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fd', '<cmd>MerlinLocateIntf<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',ft', '<cmd>MerlinTypeOf<cr>', { buffer = true, silent = true })
    vim.keymap.set('v', ',ft', '<cmd>MerlinTypeOfSel<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fy', '<cmd>MerlinYankLatestType<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', ',fo', '<cmd>MerlinOccurrences<cr>', { buffer = true, silent = true })
  end,
})

-- tabular
add('godlygeek/tabular')
vim.keymap.set('v', '<leader>-', ':Tabularize /-><cr>')
vim.keymap.set('v', '<leader>;', ':Tabularize /^[^:]*\\zs:<cr>')
vim.keymap.set('v', '<leader>=', ':Tabularize /^[^=]*\\zs=<cr>')

-- limelight
add('junegunn/limelight.vim')
vim.g.limelight_bop = '^#'
vim.g.limelight_eop = '\\ze\\n^#'

-- --- }}}

-- --- Style and font --------------------------------------------------------{{{
vim.opt.background = "dark"

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
  vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
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
vim.keymap.set('n', ',cl', function()
  local str = '-'
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
end, { silent = true })

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

-- fzf git files (with fallback)
vim.api.nvim_create_user_command('FzfGitFiles', function()
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
end, {})

-- fzf merlin completion
vim.api.nvim_create_user_command('FzfMerlin', function()
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
end, {})

-- --- }}}
