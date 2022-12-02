" --- General settings ---
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set autoindent

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

syntax on

" set mouse=a

" Tab for next split, | and - for spliting vertically and horizontally
map <Tab> <C-W>w
map <Bar> <C-W>v<C-W><Right>
map -     <C-W>s<C-W><Down>

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize +2<CR>
    nnoremap <Down>  :resize -2<CR>
    nnoremap <Left>  :vertical resize +2<CR>
    nnoremap <Right> :vertical resize -2<CR>
endif

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" Use c++ syntax highliting for .hpp files
autocmd BufRead,BufNewFile *.hpp set filetype=cpp

" Change :W editor command into :w editor command
call SetupCommandAlias("W", "w")
call SetupCommandAlias("Wq", "wq")
tnoremap <Esc> <C-\><C-n>

set nrformats=alpha,octal,hex

" Strip trailing whitespace by pressing F5
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Language and spellcheck
set nospell spelllang=en_us
let g:enable_spelunker_vim = 0
