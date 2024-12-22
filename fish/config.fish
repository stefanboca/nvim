if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim
    set -gx LESS -FRXS

    zoxide init fish | source
end
