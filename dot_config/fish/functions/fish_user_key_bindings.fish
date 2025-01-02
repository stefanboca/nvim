function fish_user_key_bindings
    # Vi bindings that inherit emacs bindings in insert mode
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert

    # Disable fzf history - use builtin pager
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --history=\e\cr
    end
end
