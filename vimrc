" General {{{
" -----------
" Use Vim instead of vi
set nocompatible
" Show confirmation when quitting instead of error
set confirm
" Reload file if edited outside of Vim
set autoread
" Disabled bell
set belloff=all
" Highlight column after `textwidth`
set colorcolumn=+1
" Highlight line cursor is on
set cursorline
" Increase search history
set history=1000
" Show line numbers
set number
" Maximum characters allowed per line
set textwidth=80
" Lines offset from cursor and screen left or right when scrolling
set sidescrolloff=5
" Lines offset from cursor and screen top or bottom when scrolling
set scrolloff=10
" Enable mouse
set mouse=a
" Map <Leader> to <Space>
let mapleader = ' '
" }}}

" :PlugInstall {{{
" ----------------
call plug#begin()
" Atom One colorscheme
Plug 'rakr/vim-one'
" vim-airline
Plug 'vim-airline/vim-airline'
" commentary.vim
Plug 'tpope/vim-commentary'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Vim Polyglot
Plug 'sheerun/vim-polyglot'
" ALE
Plug 'dense-analysis/ale'
" vim-gitgutter
Plug 'airblade/vim-gitgutter'
" Fugitive
Plug 'tpope/vim-fugitive'
" Emmet
Plug 'mattn/emmet-vim'
" NERDTree
Plug 'preservim/nerdtree'
" Emulate iaWriter
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'catppuccin/vim', { 'branch': 'main', 'as': 'catppuccin' }
call plug#end()
" }}}

" Brackets {{{
" ------------
" Close brackets with return
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap {<CR> {<CR>}<Esc>O
" Close brackets without return
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
" Overwrite already closed bracket
inoremap <expr>) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr>] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr>} strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" Surroud word in normal mode
nnoremap ( mmbi(<Esc>ea)<Esc>`m<Right>
nnoremap [ mmbi[<Esc>ea]<Esc>`m<Right>
nnoremap { mmbi{<Esc>ea}<Esc>`m<Right>
" Surroud word in visual mode
vnoremap ( <Esc>`<i(<Esc>`>a<Right>)<Esc>
vnoremap [ <Esc>`<i[<Esc>`>a<Right>]<Esc>
vnoremap { <Esc>`<i{<Esc>`>a<Right>}<Esc>
" }}}

" Colors {{{
" ----------
colorscheme one
set background=dark
" Use correct color palette
set termguicolors 
" Enable syntax highlighting
syntax enable
" }}}

" Backup files {{{
" ----------------
" Save in current directory, ~/.backup, and ~/tmp/
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" }}}

" Find (:find) {{{
" ----------------
set path+=**
set wildmenu
" Ignore select files and folders
set wildignore+=.DS_STORE
set wildignore+=*.swp
set wildignore+=*.git/
set wildignore+=.vscode/
set wildignore+=*node_modules/*
" }}}

" Folding {{{
" -----------
" Indent based fold
set foldmethod=indent
" Increase fold gutter
set foldcolumn=3
" Only fold upto 3 nested levels
set foldnestmax=3
" Disable folding by default
set nofoldenable
" Shift+Tab toggles fold
nnoremap <S-Tab> za
" }}}

" Indentation {{{
" ---------------
" Indent using <Tab>s
set tabstop=2
set shiftwidth=2
" Inherit line indentation
set autoindent
" File type based indentation
if has("autocmd")
  filetype plugin indent on
endif
" }}}

" Netrw file manager {{{
" ----------------------
" Disable banner
let g:netrw_banner=0
" Tree style file list
let g:netrw_liststyle=3
" Opening a new file replaces previous
let g:netrw_browse_split=4
" Open split windows on right
let g:netrw_altv=1
" Width percentage
let g:netrw_winsize=25
" Hide files in .gitignore
let g:netrw_list_hide=netrw_gitignore#Hide()
" CTRL+b opens Netrw
nnoremap <silent><C-b> :Vexplore<CR>
" }}}

" Quotes {{{
" ----------
" Add single quotes around word
nnoremap qw :silent! normal mpea'<ESC>bi'<ESC>`pl
" Add double quotes around word
nnoremap qd :silent! normal mpea"<ESC>bi"<ESC>`pl
" Remove quotes around word
nnoremap wq :silent! normal mpeld bhd `ph<CR>
" }}}

" Search buffer (window) {{{
" --------------------------
" Highlight search results
set hlsearch
" Search ignores case
set ignorecase
" Highlight partial query matches
set incsearch
" Case sensitive search if query contains uppercase
set smartcase
" CTRL+l clears highlighted search results
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" }}}

" Spelling {{{
" ----------------
function! ToggleSpell()
  set spell!
endfunction

" Toggle spell-checking with Leader+s
nnoremap <silent><Leader>s :call ToggleSpell()<CR>
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Spell-check Markdown files
autocmd FileType markdown setlocal spell
" Spell-check Git messages
autocmd FileType gitcommit setlocal spell
" }}}

" Split {{{
" ------------
" Always split below
set splitbelow
" Always split right
set splitright
" Resize splits
nnoremap <silent><Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent><Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" }}}

" Tabs {{{
" --------
" Ctrl+t creates new tab
map <C-t> <Esc>:tabnew<CR>
" Ctrl+Shift+Right switches to next tab
map <C-S-Right> <Esc>:tabnext<CR>
" Ctrl+Shift+Left switches to previous tab
map <C-S-Left> <Esc>:tabprev<CR>
" }}}

" Tab completion {{{
" ------------------
set wildmode=list:longest,list:full

function! InsertTabWrapper()
	let col = col('.') - 1

	if !col || getline('.')[col - 1] !~ '\k'
		" If at start of line insert <Tab> character
		return "\<Tab>"
	else
		" Else show auto-complete
		return "\<C-p>"
endfunction

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
" }}}

" Terminal {{{
" ------------
" Open terminal in split-below
map <Leader>t <esc>:bot term<CR>
" }}}

" Whitespace characters {{{
" -------------------------
set listchars=""
set listchars+=tab:▸\ 
set listchars+=trail:·
set listchars+=extends:>
set listchars+=precedes:<
set listchars+=nbsp:+
"set listchars+=eol:¬
" Always show whitespace characters
set list
"  }}}

" Airline {{{
" ------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" }}}

" Comments {{{
" ------------
nnoremap <Leader>/ :Commentary<CR>
" }}}

" Fuzzy find (fzf) {{{
" --------------------
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" }}}

" Goyo and Limelight {{{
" ----------------------
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <silent><Leader>z :Goyo<cr>
" }}}

" Grep (rg) {{{
" -------------
" Use rg instead of grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

" K greps word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Navigate quickfix list
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" }}}

" Linting {{{
" -----------
"let g:ale_sign_error = '🚩'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
" }}}

" Compile {{{
" -----------
" Go
autocmd FileType go map <buffer> <Leader>r :w<CR>:exec '!clear; go run' shellescape(@%, 1)<CR>
autocmd FileType go imap <buffer> <Leader>r <esc>:w<CR>:exec '!clear; go run' shellescape(@%, 1)<CR>
" Node
autocmd FileType javascript,typescript map <buffer> <Leader>r :w<CR>:exec '!clear; node' shellescape(@%, 1)<CR>
autocmd FileType javascript,typescript imap <buffer> <Leader>r <esc>:w<CR>:exec '!clear; node' shellescape(@%, 1)<CR>
" Python
autocmd FileType python map <buffer> <Leader>r :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <Leader>r <esc>:w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>

" vim: foldmethod=marker
