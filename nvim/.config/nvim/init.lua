local vim = vim

-- === Language ===
vim.opt.langmenu = "en_US.UTF-8"
vim.opt.helplang = "en"

-- === Plugin Manager Setup ===
-- vim-plug setup
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
Plug('cocopon/iceberg.vim')
Plug('MarcWeber/vim-addon-mw-utils')
Plug('garbas/vim-snipmate')
Plug('kaarmu/typst.vim')
Plug('jiangmiao/auto-pairs')
Plug('psliwka/vim-smoothie')
Plug('lewis6991/gitsigns.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('tpope/vim-fugitive')
Plug('petertriho/nvim-scrollbar')
Plug('kevinhwang91/nvim-hlslens')
Plug('nvim-tree/nvim-web-devicons')
Plug('ryanoasis/vim-devicons')
Plug('akinsho/bufferline.nvim', { tag = '*' })
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('nvim-lualine/lualine.nvim')
vim.call('plug#end')

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

-- Trigger autoread when files change on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

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

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
    view = {
		side = "right"
	}
})
vim.api.nvim_set_keymap('n', '<C-s>', ':NvimTreeToggle()<CR>', { noremap = true, silent = true })

-- === gitsigns ===
require('gitsigns').setup()

-- === Scrollbar ===
require("scrollbar").setup({
    marks = {
        Cursor = {
            text = "-",
            priority = 0,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "Normal",
        },
    },
    handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = true,
    },
})

-- Gvdiffsplit command
vim.cmd [[command! Gdiff horizontal Gdiffsplit | wincmd r]]

-- === Fzf ===
vim.api.nvim_set_keymap('n', '<C-t>', ':Files<CR>', { noremap = true, silent = true })
vim.g.fzf_action = { ['enter'] = 'tab drop' }

-- === coc ===
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

--- === tab ===
vim.opt.termguicolors = true
vim.api.nvim_set_keymap('n', 'gt', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gT', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gq', ':bdelete<CR>', { noremap = true, silent = true })
require("bufferline").setup{
    options = {
        indicator = {
            style = 'none'
        },
    },
}

-- === status line ===
require('lualine').setup({
    options = {
        theme = 'iceberg_dark',
    }
})

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
