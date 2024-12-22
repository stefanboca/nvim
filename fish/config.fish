if status is-interactive
    set -gx EDITOR nivm
    set -gx LESS -FRXS

    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
end
