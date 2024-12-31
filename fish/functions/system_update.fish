function __system_update_run
    set -f cmd $argv[1]

    set -f test_cmd $argv[1]
    if set -q argv[2]
        set test_cmd $argv[2]
    end

    if command -q $test_cmd
        echo (set_color --bold cyan)"Running `$cmd`..."(set_color normal)

        eval $cmd
        and echo (set_color --bold cyan)"Done running `$cmd`."(set_color normal)
        or echo (set_color --bold red)"Error running `$cmd`."(set_color normal)
    end
end

function system_update --description "Update all the things"
    __system_update_run "sudo dnf upgrade --refresh" dnf
    __system_update_run "flatpak update"
    __system_update_run "fisher update"
    __system_update_run "uv self update"
    __system_update_run "uv tool upgrade --all"
    __system_update_run "rustup self update"
    __system_update_run "rustup update"
    __system_update_run "cargo install-update -a" cargo-install-update
    __system_update_run "tldr --update"
end
