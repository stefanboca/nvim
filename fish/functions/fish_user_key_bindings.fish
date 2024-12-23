function fish_user_key_bindings --description "Vi-style bindings that inherit emacs-style bindings in insert mode"
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end
