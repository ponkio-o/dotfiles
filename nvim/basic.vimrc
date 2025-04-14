filetype off
filetype plugin indent on

" 改行の自動コメントアウト無効化
autocmd FileType * setlocal formatoptions-=ro

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
" vim-gitgutter などの反映速度を上げる
set updatetime=100
" 全てのモードでマウススクロールを有効化
set mouse=a

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:»-,trail:-,nbsp:%,eol:↲
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

" Syntax
autocmd ColorScheme * highlight LineNr ctermfg=239
syntax enable
colorscheme molokai
set t_Co=256

" コメント文字とVisualmodeのカラースキーム変更
if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermfg=236
endif

"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf8
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

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

" indent setting
if has("autocmd")
  filetype plugin on
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
  autocmd FileType c       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html    setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yml     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python  setlocal sw=4 sts=4 ts=4 et
  autocmd BufNewFile,BufRead */.ssh/ssh_conf/* setf sshconfig
endif

" ヤンクとクリップボードを共有
set clipboard=unnamed

" キーコードシーケンスの時間(e.g. leader)
set timeout timeoutlen=500

" Undo の永続化
if has('persistent_undo')
  set undodir=~/.vim/.undo
  set undofile
endif

" Backspace を有効化
set backspace=2

" 保存時に行末のスペースを削除
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    " 'markdow\|javascript\|...'
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//ge
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" Quickfix だけの場合は自動的に閉じる
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" jq でフォーマットするためのコマンド
fun! FormatJq()
    %!jq '.'
    set filetype=json
endfun
command! Jqf call FormatJq()

" コメントがあるとエラーになるので json5 の場合には jsonc に設定する
autocmd BufNewFile,BufRead *.json5 setlocal filetype=jsonc
