function __system_update_run
    argparse "t/test-cmd=" q/quiet -- $argv
    set -l cmd $argv

    if not set -q _flag_test_cmd
        set _flag_test_cmd $cmd[1]
    end

    if type -q $_flag_test_cmd
        echo (set_color --bold cyan)"Running `$cmd`..."(set_color normal)

        if set -q _flag_quiet
            $cmd >/dev/null
        else
            $cmd
        end
        and echo -e (set_color --bold green)"Done running `$cmd`.\n"
        or echo -e (set_color --bold red)"Error running `$cmd`.\n"
        set_color normal
    end
end

function system_update --description "Update all the things"
    __system_update_run -t dnf -- sudo dnf upgrade --refresh
    __system_update_run flatpak update
    __system_update_run -q -- fisher update
    __system_update_run uv self update
    __system_update_run -- uv tool upgrade --all
    __system_update_run rustup self update
    __system_update_run rustup update
    __system_update_run -t cargo-install-update -- cargo install-update -a
    __system_update_run -- tldr --update
end
