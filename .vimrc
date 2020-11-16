" ne true setting
syntax on
filetype plugin indent on
" All you can set 
set lazyredraw
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set splitbelow splitright
set background=dark
set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=80
" Plugins 
call plug#begin('~/.vim/plugged')

"Plug 'neovim/nvim-lspconfig
"Plug 'nvim-lua/completion-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
"Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'ThePrimeagen/vim-be-good'
Plug 'gruvbox-community/gruvbox'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
"Plug 'dhruvasagar/vim-table-mode'
Plug 'jiangmiao/auto-pairs'

" telescope?

call plug#end()
" Mappings
let mapleader = " "

map <silent> <leader>h :wincmd h<CR>
map <silent> <leader>j :wincmd j<CR>
map <silent> <leader>k :wincmd k<CR>
map <silent> <leader>l :wincmd l<CR>

noremap <silent> <Leader>vr :vertical resize 30<CR>
noremap <silent> <Leader>r+ :vertical resize +5<CR>
noremap <silent> <Leader>r- :vertical resize -5<CR>

noremap <silent> <Leader>u :UndotreeToggle<CR>
noremap <silent> <Leader>g :Goyo<CR>

noremap <Leader>fg :GRg<CR>
noremap <Leader>fw :WikiRg<CR>
noremap <silent> <Leader>ff :Files<CR>
noremap <silent> <Leader>fF :Files ~<CR>

noremap <silent> <Leader>t :split <Bar> :term<CR>

noremap <silent> <Leader><Enter> o<Esc>

noremap <silent> <Leader>cn :cn<CR>
noremap <silent> <Leader>cp :cp<CR>
noremap <silent> <Leader>ccl :ccl<CR>

noremap <Leader>ii :call OpenImage()<CR>
noremap <Leader>xx cwXXXX<ESC>jjhhh

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

noremap <silent> <Leader>sc :setlocal spell! spelllang=en_us<CR>

inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Lets

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1


let g:vimwiki_table_mappings = 0
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/', 
            \'syntax' : 'markdown', 'ext': '.md'}]



let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let $FZF_DEFAULT_OPTS='--reverse'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

let g:gruvbox_bold= 1
let g:gruvbox_italic= 1
colorscheme gruvbox

highlight Normal ctermbg=None guibg=None
"highlight! NonText ctermbg=None guibg=None

" Functions

function! OpenImage()
    set iskeyword+=43,45-47,58,61,92
    term timg <cword>
    set iskeyword-=43,45-47,58,61,92
    startinsert
endfunction

command! -bang -nargs=* WikiRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
  \1, {'dir': "~/.vim/vimwiki/"}, <bang>0)

command! -bang -nargs=* GRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 
  \1, {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction



function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:goyo_enter()
    set wrap linebreak
    set showmode
"    set columns 80
endfunction

function! s:goyo_leave()
    set nowrap
    set noshowmode
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
