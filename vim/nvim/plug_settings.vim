" ----- Plugin-Specific Settings --------------------------------------
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
" let g:neomake_place_signs = 1
" let g:neomake_cpp_gcc_maker = { 'exe': 'g++', 'args': ['-Wall', '-Iinclude', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion']}
" let g:neomake_cpp_clang_maker = { 'exe': 'clang++', 'args': ['-Wall', '-Iinclude', '-Iextern', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion']}
" call neomake#configure#automake('nw', 750)

" ----- Autocompletion -----
" let g:deoplete#enable_at_startup = 1
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-n>" : deoplete#manual_complete()
" inoremap <expr> <CR>  pumvisible() ? deoplete#close_popup() : "\<CR>"

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-b>"
" let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" ----- altercation/vim-colors-solarized settings -----
" Toggle this to "light" for light colorscheme
" set background=dark
" Uncomment the next line if your terminal is not configured for solarized
" let g:solarized_termcolors=256
" Set the colorscheme
" colorscheme solarized

" ----- romainl/flattened settings -----
" colorscheme flattened_dark
set termguicolors

" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" Use the solarized theme for the Airline status bar
let g:airline_theme='base16_gruvbox_dark_hard'

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
" let g:nerdtree_tabs_open_on_console_startup = 0


" " ----- scrooloose/syntastic settings -----
" let g:syntastic_error_symbol = 'x'
" let g:syntastic_warning_symbol = ">"
" augroup mySyntastic
"     au!
"     au FileType tex let b:syntastic_mode = "passive"
" augroup END
"
" ----- scrooloose/nerdcommenter settings -----
" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
" set tags=./tags;,~/.vimtags
" Sensible defaults
" let g:easytags_events = ['BufReadPost', 'BufWritePost']
" let g:easytags_async = 1
" let g:easytags_dynamic_files = 2
" let g:easytags_resolve_links = 1
" let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
" nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)


" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
" let g:airline#extensions#hunks#non_zero_only = 1


" ----- Raimondi/delimitMate settings -----
" let delimitMate_expand_cr = 1
" augroup mydelimitMate
    " au!
    " au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
    " au FileType tex let b:delimitMate_quotes = ""
    " au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
    " au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
" augroup END

" ----- jez/vim-superman settings -----
" better man page support
" noremap K :SuperMan <cword><CR>

" let g:localvimrc_sandbox = 0

" nnoremap <C-b> :make<CR>

" SCVim
" let g:sclangTerm = "kitty @ launch --type=tab --keep-focus $SHELL -c"
" let g:scFlash = 1
" let g:scTerminalBuffer = "on"

" vim-easyescape
" let g:easyescape_chars = { "j": 1, "k": 1 }
" let g:easyescape_timeout = 100
" cnoremap jk <ESC>
" cnoremap kj <ESC>

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
