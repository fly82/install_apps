syntax on
let loaded_matchparen = 1
let mapleader="\<Space>"

set path+=**
set wildmode=longest,list,full
set wildmenu
set wildignore+=**/.git/*
set wildignorecase

set number relativenumber colorcolumn=80 signcolumn=yes
set nohlsearch incsearch
set nowrap
set ignorecase
set smartcase
set smarttab
set magic
set bs=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 et si
set noswapfile
set hidden noswapfile nobackup undofile undodir=~/.vim/undodir
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set cmdheight=2
set shortmess+=c
hi ColorColumn ctermbg=0 guibg=lightgrey

iabbr email vadifly@gmail.com

" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

nnoremap <silent> <leader>/ :nohlsearch<CR>

" if this is a normal buffer use <CR> to toggle folding
nmap <expr> <CR> &buftype ==# '' ? 'za' : "\<CR>"

" change variable and repeat with .
nnoremap c*			*Ncgn
nnoremap <C-N>      yiW/<C-r>0<CR>Ncgn
xnoremap <C-N>      y/<C-r>0<CR>Ncgn

map ]a :silent! cnext<CR>
map [a :silent! cprevious<CR>
map ]A :silent! lnext<CR>
map [A :silent! lprevious<CR>

map ]t :silent! tnext<CR>
map [t :silent! tprevious<CR>

"quick buffer navigation
nnoremap ]b :silent! bnext<CR>
nnoremap [b :silent! bprevious<CR>

" Find Files {{{2 "
nnoremap <leader>a   :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>b   :b <C-d>
nnoremap <leader>ft  :setfiletype<space>
nnoremap <leader>ff  :edit <c-r>=FindRootDirectory()<CR>/**/*
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
nnoremap <leader>j   :tjump /
nnoremap <leader>hh  :help<Space>

" bookmarked directories
nnoremap <leader>fw  :edit ~/.
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fh  :edit ~/**

nnoremap <leader>fj  :ME<space>
command! -nargs=1 -complete=customlist,dotvim#MRUComplete ME call dotvim#MRU('edit', <f-args>)
" 2}}} "Find Files

" better navigation of command history
" allow next completion after / alternative
" is <C-E> if <C-D> makes to long of a list
if has('nvim-0.5.0')
	cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"
else
	cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
endif

"quick substitution
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))

" better alternative to <C-W>_<C-W>\|
nnoremap <C-W>z		<C-W>_<C-W>\|
nnoremap <C-W><C-z>	<C-W>_<C-W>\|

"Better Mappings Imho
nnoremap gf gF
xnoremap * "xy/<C-R>x<CR>

" close preview if open when hitting escape
nnoremap <silent> <esc> :pclose<cr>

" copy all matches with the last seach
nmap ym :YankMatch<CR>
" delete matches
nmap dm :%s/<c-r>///g<CR>
" change matches
nmap cm :%s/<c-r>///g<Left><Left>

" Using Fugitive
nnoremap Q  :Gstatus<CR>

" buf-search
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" #!! | Shebang
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" Open in IntelliJ
nnoremap <silent> <leader>ij :call system('nohup "/Applications/IntelliJ IDEA.app/Contents/MacOS/idea" '.expand('%:p').'> /dev/null 2>&1 < /dev/null &')<cr>

" Etc {{{1 "
" Diffs: {{{2 "
if has('patch-8.1.0283')
	set diffopt=vertical,filler,context:3,
				\indent-heuristic,algorithm:patience,internal
endif
" 2}}} "Diffs
" Local Settings {{{ "2
if filereadable(expand('~/.config/vimlocal'))
	source ~/.config/vimlocal
endif
" 2}}} "Local Settings
"}}} Etc "

xnoremap <leader>ht :Heytmux<cr>

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>`        :Marks<CR>

inoremap <C-c> <esc>
nnoremap - $
nnoremap Y y$
cnoremap q1 q!

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

noremap x "_x
vnoremap X "_d

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

nnoremap <leader>w :update<cr>
nnoremap <leader>nn :set nu! rnu!<cr>

cmap w!! w !sudo tee % > /dev/null
nnoremap <leader>q :wq<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
noremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>pf :Files<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" nnoremap <Leader><CR> :so ~/.vimrc<CR>

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

if executable('rg')
    let g:rg_derive_root='true'
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
else
	set grepprg=grep\ -R\ -n\ --exclude-dir=.git,.cache
endif

" POSIX Commands
nmap cd :cd <C-R>=expand('%:h')<CR>

" mark position before search
nnoremap / ms/

" install vim-plug if it's not already
augroup PLUGGED
	if empty(glob('~/.vim/autoload/plug.vim'))  " Vim
		silent !curl -fo ~/.vim/autoload/plug.vim --create-dirs
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
augroup end
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-speeddating', { 'for': [ 'org', 'dotoo', 'rec' ] }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease', {'on': []}
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gpush', 'Gedit', 'Ggrep'] }
if has('nvim') || has('patch-8.0.902')
	Plug 'mhinz/vim-signify'
endif
	Plug 'mhinz/vim-signify'
" 2}}} "Git
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
call plug#end()

colorscheme gruvbox
set bg=dark

function! FindRootDirectory()
    if !filereadable('Makefile') && !filereadable('makefile')
        let root = systemlist('git rev-parse --show-toplevel')[0]
        if v:shell_error
            return '.'
        endif
        return root
    endif
    return expand('%:p:h')
endfunction

function! RootMe()
    let root = FindRootDirectory()
    if root ==# ''
    endif
    execute 'lcd' . root
    echo 'Changed directory to: '.root
endfunction

command! Root call RootMe()
" set directory to root before following tags
nnoremap <c-]> :call FindRootDirectory()<CR>:tag <c-r><c-w><CR>
