function _load_fnm
    if not set -q __fnm_loaded
        set -g __fnm_loaded
        fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --shell fish | source
    end
end
