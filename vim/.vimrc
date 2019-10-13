" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle 
call vundle#rc() 
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-markdown'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'

call vundle#end()
filetype plugin indent on

" Syntax
autocmd ColorScheme * highlight LineNr ctermfg=239
syntax enable
colorscheme molokai
set t_Co=256 " setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 改行時に#を入力しない
autocmd FileType * setlocal formatoptions-=ro
" Esc変更
noremap <C><Space> <Esc>
" クリップボード共有
set clipboard=unnamedplus

" 見た目系
" 行番号を表示
set number
" Syntax
syntax on
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

if has("autocmd")
  filetype plugin on
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
  autocmd FileType c       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html    setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python  setlocal sw=4 sts=4 ts=4 et
  autocmd BUfNewFile,BufRead */.ssh/ssh_conf/* setf sshconfig
endif





" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" コメント文字とVisualmodeのカラースキーム変更
if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermfg=236
endif

""" markdown preview
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
" Need: kannokanno/previm
nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1

" tex compiler
nnoremap <silent> <C-t> :!texc -b %<CR> " Ctrl-pでプレビュー
