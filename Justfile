default:
	@just --choose

install-all: install-lvim

install-lvim:
	@echo "Installing LunarVim..."
	@wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O /tmp/install_lvim.sh
	@chmod +x /tmp/install_lvim.sh
	@/tmp/install_lvim.sh --no-install-dependencies
	@rm /tmp/install_lvim.sh
