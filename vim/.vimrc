" === Language ===
language en_US

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
call plug#end()


" === Function ===
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
set smartcase

" Set scrolloff.
set scrolloff=5

" === Appearance ===
" Set color theme.
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

" Set git gutter.
let g:gitgutter_async=0

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
