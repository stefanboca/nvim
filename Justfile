default:
    @just --choose

install-all: install-dotfiles install-tpm

install-dotfiles:
  @echo "Installing dotfiles..."
  dotter

install-omz:
  @echo "Installing Oh My Zsh..."
  env ZSH="$HOME/.config/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-tpm:
  @echo "Instaling TPM..."
  mkdir -p ~/.config/tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

