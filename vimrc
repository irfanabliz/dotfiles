" Settings Set standard file encoding
set encoding=utf8
" not compatible with vi
set nocompatible
" No special per file vim override configs
set nomodeline
" detect when a file is changed
set autoread
" Stop word wrapping
set nowrap
	" Except... on Markdown. That's good stuff.
  	autocmd FileType markdown setlocal wrap
" Adjust system undo levels
set undolevels=100
" Use system clipboard
set clipboard=unnamed
" Set tab width and convert tabs to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" Don't let Vim hide characters or make loud dings
set conceallevel=1
set noerrorbells
" Number gutter
set number
" Use search highlighting
set hlsearch
" Space above/beside cursor from screen edges
set scrolloff=1
set sidescrolloff=5
" Remapping <Leader> to <Space>
let mapleader="\<SPACE>"
" Disable mouse support
set mouse=r
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" Setting Arrow Keys to Resize Panes
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>
" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" Return to the last file opened
nmap <Leader><Leader> <c-^>
nnoremap <Tab> :bnext!<CR>
nnoremap <S-Tab> :bprev!<CR><Paste>

" Plugin Manager
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/unite.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
" emmet {{{
  Plug 'mattn/emmet-vim'
" }}}
" airline {{{
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" }}}
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mhinz/vim-grepper'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'justinmk/vim-sneak'
" syntax highlight and colors {{{
  Plug 'joshdick/onedark.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
" }}}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-surround'
" NERDTree {{{
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin'
" }}}
" Load this after all the plugin
Plug 'ryanoasis/vim-devicons'

call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:onedark_termcolors=256
" syntax highlight
syntax on
colorscheme onedark

" indent guide settings
let g:indentLine_enabled = 1
let g:indentLine_char = "·"

" airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts=1
set laststatus=2

" Fuzzy finder
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>t :CtrlP<CR>

" vim-grepper
nnoremap <Leader>fp :Grepper<Space>-query<Space>
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" vim-sneak
let g:sneak#s_next = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" NerdTree
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1

" Enable .jsx syntax highlight for .js
let g:jsx_ext_required = 0
augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" ALE eslint
let g:ale_linters = {'jsx': ['stylelint', 'eslint'], 'javascript': ['eslint']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_javascript_eslint_use_global = 0




let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
augroup devicons
  autocmd!
  autocmd FileType nerdtree setlocal nolist
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END



let g:user_emmet_leader_key='<C-Z>,'
