set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_CACHE_HOME ~/.cache

set -gx CUDA_CACHE_PATH $XDG_CONFIG_HOME/nv
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx LEIN_HOME $XDG_DATA_HOME/lein
set -gx NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx NPM_CONFIG_TMP $XDG_RUNTIME_DIR/npm
set -gx PYTHON_HISTORY $XDG_STATE_HOME/python_history

set --path -gx TERMINFO_DIRS $XDG_DATA_HOME/terminfo /usr/share/terminfo

set -gx GOPATH $XDG_DATA_HOME/go
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx ELAN_HOME $XDG_DATA_HOME/elan
set -gx PIXI_HOME $XDG_DATA_HOME/pixi

fish_add_path -g ~/.local/bin $CARGO_HOME/bin $GOPATH/bin $PIXI_HOME/bin $ELAN_HOME/bin

set -gx EDITOR ~/.local/bin/nvim
set -gx LESS -FRXS
