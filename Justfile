default:
    @just --choose

install-all: install-dotfiles install-zsh-theme

install-dotfiles:
    @echo "Installing dotfiles..."
    dotter
install-zsh-theme:
    @echo "Instaling ZSH theme..."
    ln -s -f $PWD/zsh/mytheme.zsh-theme ~/.cache/antigen/bundles/robbyrussell/oh-my-zsh/themes/mytheme.zsh-theme
