-- === Language ===
vim.opt.langmenu = "en_US.UTF-8"
vim.opt.helplang = "en"

-- === Plugin Manager Setup ===
-- vim-plug setup
vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')
  
  " Plugins
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'garbas/vim-snipmate'
  Plug 'kaarmu/typst.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'psliwka/vim-smoothie'
  Plug 'airblade/vim-gitgutter'
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'

  call plug#end()
]]

-- === Behavior ===
-- Escape with jk or kj
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })

-- Change cursor on insert and normal mode
vim.cmd [[
  autocmd InsertEnter * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  autocmd InsertLeave * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
]]

-- Tab for 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Ignore case in search, but be smart about it
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Autoreload changed file
vim.cmd [[
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * 
  if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]]

-- === Appearance ===
-- Set color scheme
vim.opt.background = 'dark'
vim.cmd('colorscheme iceberg')
vim.opt.termguicolors = true

-- Show line number
vim.opt.number = true

-- Highlight search
vim.opt.hlsearch = true

-- Syntax highlighting
vim.cmd('syntax on')

-- Scrolloff
vim.opt.scrolloff = 5

-- === NERDTree ===
vim.g.NERDTreeWinPos = 'right'
vim.api.nvim_set_keymap('n', '<C-s>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- === ALE Settings ===
vim.g.ale_enabled = 1
vim.g.ale_linters = {
  rust = { 'clippy' },
  python = { 'flake8' },
  cpp = { 'clangtidy' },
  cs = { 'clangtidy' }
}
vim.g.ale_fixers = {
  rust = { 'rustfmt' },
  python = { 'autopep8' },
  cpp = { 'clang-format' },
  cs = { 'clang-format' },
  typescript = { 'prettier', 'eslint' },
  typescriptreact = { 'prettier', 'eslint' }
}
vim.g.ale_sign_column_always = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_completion_enabled = 1

-- === GitGutter ===
vim.g.gitgutter_async = 0

-- Gvdiffsplit command
vim.cmd [[command! Gdiff horizontal Gdiffsplit | wincmd r]]

-- === Fzf ===
vim.api.nvim_set_keymap('n', '<C-t>', ':Files<CR>', { noremap = true, silent = true })
vim.g.fzf_action = { ['enter'] = 'tab drop' }

-- === Utils ===
-- Change TMUX pane title to filename
if os.getenv('TMUX') then
  vim.cmd [[
    autocmd BufEnter * call system("tmux select-pane -t c-pro.0 -T '" . expand("%:f") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
  ]]
end

-- Silent command
vim.cmd [[command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!']]

-- C-pro key mappings for TMUX
vim.api.nvim_set_keymap('n', '<F2>i', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_inputtest.sh" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>c1', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 1" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>c2', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 2" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>c3', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 3" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>c4', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 4" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>u', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cptest.sh" Enter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>sss', ':Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_submit.sh" Enter<CR>', { noremap = true, silent = true })
