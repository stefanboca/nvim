default:
    @just --choose

install-all: install-lvim install-dotfiles install-zsh-theme

install-dotfiles:
    @echo "Installing dotfiles..."
    dotter

install-lvim:
    @echo "Installing LunarVim..."
    wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O /tmp/install_lvim.sh
    chmod +x /tmp/install_lvim.sh
    /tmp/install_lvim.sh --no-install-dependencies
    rm /tmp/install_lvim.sh

install-zsh-theme:
    @echo "Instaling ZSH theme..."
    ln -s -f $PWD/zsh/mytheme.zsh-theme ~/.cache/antigen/bundles/robbyrussell/oh-my-zsh/themes/mytheme.zsh-theme
