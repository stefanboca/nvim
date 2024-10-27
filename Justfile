default: update-all

install-omz:
  @echo "Installing Oh My Zsh..."
  env ZSH="$HOME/.config/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

update-all: update-dnf update-flatpak update-rust update-crates update-uv update-omz update-tldr

update-dnf:
  sudo dnf upgrade --refresh

update-flatpak:
  flatpak update

update-rust:
  rustup self update
  rustup update

update-crates:
  cargo install-update -a

update-uv:
  uv self update
  uv tool upgrade --all

update-omz:
  $ZSH/tools/upgrade.sh

update-tldr:
  tldr --update
