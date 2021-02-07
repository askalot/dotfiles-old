" General {{{
" -----------
" Use Vim instead of vi
set nocompatible
" Reload file if edited outside Vim
set autoread
" Increase search history
set history=1000
" Set maximum characters per line
set textwidth=80
" Turn off bell
set belloff=all
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Enable mouse scroll
set mouse=a
" jj exists Insert Mode
:imap jj <Esc>
" map Leader key to comma
let mapleader = ','
" show confirmation when quitting, instead of throwing error
set confirm
" }}}

" :PlugInstall vim-plug plugins {{{
" ---------------------------------
call plug#begin()
" Better status bar
Plug 'vim-airline/vim-airline'
" Atom One colour scheme
Plug 'rakr/vim-one'
" Better syntax highlighting
Plug 'sheerun/vim-polyglot'
" Fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" emmet
Plug 'mattn/emmet-vim'
" ESLint
Plug 'dense-analysis/ale'
" vim-fugitive
Plug 'tpope/vim-fugitive'
call plug#end()
" }}}

" fzf {{{
" -------
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" }}}

" ESLint {{{
" ----------
let g:ale_sign_error = '🚩'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
" Automatically fix files on save
let g:ale_fix_on_save = 1
" }}}

" Colours {{{
" -----------
colorscheme one
set background=light
" Use correct colour palette
set termguicolors
" Enable syntax highlighting
syntax enable
" Highlight cursor line
set cursorline
" Highlight column after textwidth
set colorcolumn=+1
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
"Always show whitespace characters
set list
" }}}

" Line numbers {{{
" ----------------
set number
set numberwidth=5
set relativenumber
" Disable relativenumber in Insert Mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
" }}}

" Scrolling {{{
" -------------
" Number of lines offset from cursor top or bottom
set scrolloff=1
" Number of columns offset from cursor left or right
set sidescrolloff=5
" Try to show paragraph last line
set display+=lastline
" }}}

" Tabs {{{
" --------
" Ctrl+t creates new tab
map <C-t> <esc>:tabnew<CR>
" Ctrl+Shift+Left switches to next tab
noremap <C-S-left> <esc>:tabprev<cr>
" Ctrl+Shift+Right switches to previous tab
noremap <C-S-right> <esc>:tabnext<cr>
" }}}

" Folding {{{
" -----------
" Indent based fold
set foldmethod=indent
" Only fold upto 3 nested levels
set foldnestmax=3
" Disable folding by default
set nofoldenable
" Shift+Tab toggles fold
nnoremap <S-Tab> za
" }}}

" Indentation {{{
" ---------------
" Inherit line indentation
set autoindent
" Insert Mode backspace works
set backspace=indent,eol,start
" Insert Mode tabs are spaces
set expandtab
" Number of spaces in autoindent
set shiftwidth=2
" Insert shiftwidth spaces at line start
set smarttab
" Number of spaces in Insert Mode
set softtabstop=2
" File type based indentation
if has("autocmd")
  filetype plugin indent on
endif
" }}}

" Tab completion {{{
" ------------------
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    " If at line start use Tab
    return "\<Tab>"
  else
    " Else show auto-complete
    return "\<C-p>"
  endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
" }}}

" Window search {{{
" -----------------
" Highlight search results
set hlsearch
" Search ignores case
set ignorecase
" Highlight partial query matches
set incsearch
" Case sensitive search if query contains uppercase
set smartcase
" CTRL+L clears highlighted search results
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" }}}

" :grep files {{{
" ---------------
" Use ag instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
" K greps word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }}}

" :find files {{{
" ---------------
set path+=**
set wildmenu
" Ignore select files and folders
set wildignore+=.DS_STORE
set wildignore+=*.swp
set wildignore+=*.git/
set wildignore+=.vscode/
set wildignore+=*node_modules/*
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
noremap <silent> <C-b> :Vexplore<CR>
" }}}

" quote words {{{
" ---------------
" Add single quotes around word
nnoremap qw :silent! normal mpea'<ESC>bi'<ESC>`pl
" Add double quotes around word
nnoremap qd :silent! normal mpea"<ESC>bi"<ESC>`pl
" Remove quotes around word
nnoremap wq :silent! normal mpeld bhd `ph<CR>
" }}}

" Split {{{
" ------------
nnoremap <silent><Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent><Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" }}}

" Terminal {{{
" ------------
" Always split below
set splitbelow
" Alt+m creates new tab
map <Leader>t <esc>:bot term<CR>
" }}}

" Backup files {{{
" ----------------
" Save in current directory, ~/.backup, and ~/tmp/
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" }}}

" vim:foldmethod=marker
