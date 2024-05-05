default:
    @just --choose

install-all: install-dotfiles install-tpm

install-dotfiles:
  @echo "Installing dotfiles..."
  dotter

install-tpm:
  @echo "Instaling TPM..."
  mkdir -p ~/.config/tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

