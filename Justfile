default:
	@just --choose

install-all: install-dotfiles install-lvim install-zsh-theme

install-dotfiles:
  dotter

install-lvim:
	@echo "Installing LunarVim..."
	@wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O /tmp/install_lvim.sh
	@chmod +x /tmp/install_lvim.sh
	@/tmp/install_lvim.sh --no-install-dependencies
	@rm /tmp/install_lvim.sh

install-zsh-theme:
  cp ./zsh/mytheme.zsh-theme ~/.cache/antigen/bundles/robbyrussell/oh-my-zsh/themes/mytheme.zsh-theme
