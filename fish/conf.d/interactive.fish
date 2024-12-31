status is-interactive || exit 0

set -gx EDITOR nvim
set -gx LESS -FRXS

set -gx fish_key_bindings fish_user_key_bindings

zoxide init fish | source
