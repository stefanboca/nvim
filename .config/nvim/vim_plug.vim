" this file uses vim-plug to install plugins

call plug#begin('~/.vim/plugged')

" Plug 'kamykn/popup-menu.nvim'

" Spellcheck
" Plug 'kamykn/spelunker.vim'

" TreeSitter
" if has('nvim')
"     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" endif

" ----- Remote Editing with neovim-qt ---------------------------------
" Plug 'equalsraf/neovim-gui-shim'

" ----- Making Vim look good ------------------------------------------
" Plug 'altercation/vim-colors-solarized'
" Plug 'romainl/flattened'
" Plug 'tomasr/molokai'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" ----- Making Tmux look good -----------------------------------------
" Plug 'edkolev/tmuxline.vim'

" ----- Vim as a programmer's text editor -----------------------------
" Plug 'preservim/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'vim-syntastic/syntastic'
" Plug 'neomake/neomake'
" Plug 'coddingtonbear/neomake-platformio', { 'do': ':UpdateRemotePlugins' }
" Plug 'embear/vim-localvimrc'
" Plug 'brooth/far.vim', { 'do': ':UpdateRemotePlugins' }
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
" Plug 'majutsushi/tagbar'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'vim-scripts/a.vim'
" Plug 'scrooloose/nerdcommenter'
" Plug 'supercollider/scvim'

" ----- Working with Git ----------------------------------------------
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'

" ----- Other text editing features -----------------------------------
" Plug 'Raimondi/delimitMate'
" Plug 'tpope/vim-unimpaired'
" Plug 'triglav/vim-visual-increment'
" Plug 'zhou13/vim-easyescape'

" ----- man pages, tmux -----------------------------------------------
" Plug 'jez/vim-superman'
" Plug 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ------------------------------------------------
" Plug 'sheerun/vim-polyglot'
" Plug 'jez/vim-c0'
" Plug 'jez/vim-ispc'
" Plug 'kchmck/vim-coffee-script'
" Plug 'calviken/vim-gdscript3'

" ----- Autocompletion plugins
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-neoInclude'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'ncm2/ncm2-pyclang'
" Plug 'ncm2/ncm2-vim'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" if has("nvim")
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" endif
" " Plug 'Valloric/YouCompleteMe'

" ---- Extras/Advanced plugins ----------------------------------------
if has("nvim")
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif
" Plug 'ntpeters/vim-better-whitespace'
" Plug 'tpope/vim-surround'

call plug#end()
