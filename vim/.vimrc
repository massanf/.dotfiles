" === Language ===
language messages en_US.UTF-8

" === Plugins ===
" `:PlugInstall` to install these.
call plug#begin()
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
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


" === Behavior ===
" Escape with jk or kj.
imap jk <Esc>
imap kj <Esc>

" Change cursor on insert and normal.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Reset the cursor on start (for older versions of vim, usually not required).
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Tab for 4 spaces.
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Ignore case if it's all lower.
set ignorecase
set smartcase

" Autoreload changed file.
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" === Appearance ===
" Set color theme.
set background=dark
colorscheme iceberg
if (has("termguicolors"))
  set termguicolors
endif

" Show line number.
set number

" Highlight find.
set hlsearch

" Set syntax highlighting.
syntax on


" === Plugin Settings ===
" Set scrolloff.
set scrolloff=5

" NERDTree
let g:NERDTreeWinPos = "right"
nmap <C-s> :NERDTreeToggle<cr>

" Linter.
let g:ale_enabled = 1
let g:ale_linters = {
    \ 'rust': ['clippy'],
    \ 'python': ['flake8'],
    \ 'cpp': ['clangtidy'],
    \ 'cs': ['clangtidy'],
    \ }
let g:ale_fixers = {
    \ 'rust': ['rustfmt'],
    \ 'python': ['autopep8'],
    \ 'cpp': ['clang-format'],
    \ 'cs': ['clang-format'],
    \ 'typescript': ['prettier', 'eslint'],
    \ 'typescriptreact': ['prettier', 'eslint'],
    \ }
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_completion_enabled = 1

" Set git gutter.
let g:gitgutter_async=0

" Changes on the left with :Gvdiffsplit.
command! Gdiff horizontal Gdiffsplit | wincmd r

" Fzf.
nnoremap <C-t> :Files<CR>
let g:fzf_action = { 'enter': 'tab drop' }


" == Utils ==
" Change TMUX pane title to filename.
if exists('$TMUX')
    autocmd BufEnter * call system("tmux select-pane -t c-pro.0 -T '" . expand("%:f") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
endif

" Run commands silently. 
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" == C-pro ==
" Map keys for c-pro.
nnoremap <F2>i :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_inputtest.sh" Enter<CR>
nnoremap <F2>c1 :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 1" Enter<CR>
nnoremap <F2>c2 :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 2" Enter<CR>
nnoremap <F2>c3 :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 3" Enter<CR>
nnoremap <F2>c4 :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cpsample.sh 4" Enter<CR>
nnoremap <F2>u :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_cptest.sh" Enter<CR>
nnoremap <F2>sss :Silent tmux send-keys -t c-pro:0.4 "onlinejudge/call_submit.sh" Enter<CR>
