" vim-plug
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kannokanno/previm'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/vim-sonictemplate'
Plug 'mechatroner/rainbow_csv'
Plug 'yasuhiroki/circleci.vim'
Plug 'hashivim/vim-terraform'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-fugitive'
Plug 'tsandall/vim-rego'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'andrewstuart/vim-kubernetes'
Plug 'Chiel92/vim-autoformat'
Plug 'tyru/open-browser.vim'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-sandwich'
call plug#end()
