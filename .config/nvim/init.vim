" To install vim-plug run
"   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" and then run
"   :PlugInstall
" and
"   :UpdateRemotePlugins

if !exists('g:vscode')
    source ~/.config/nvim/vim_plug.vim
    " source ~/.config/nvim/settings.vim
    " source ~/.config/nvim/plug_settings.vim

    " if has('nvim')
    "     source ~/.config/nvim/treesitter.vim
    " endif

    set exrc
    set secure
endif
