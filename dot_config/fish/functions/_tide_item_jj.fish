function _tide_item_jj
    command -q jj && jj --ignore-working-copy root &>/dev/null || return 1

    set -q tide_jj_description_color && set description_color (set_color $tide_jj_description_color | string escape)
    set -q tide_jj_conflict_color && set conflict_color (set_color $tide_jj_conflict_color | string escape)
    set -q tide_jj_divergent_color && set divergent_color (set_color $tide_jj_divergent_color | string escape)
    set -q tide_jj_hidden_color && set hidden_color (set_color $tide_jj_hidden_color | string escape)

    _tide_print_item jj $tide_jj_icon' ' (
        jj log -r@ --ignore-working-copy --no-pager --no-graph --color always -T "
        separate(' ',
            change_id.shortest(8),
            commit_id.shortest(8),
            bookmarks.map(|x| if(
                x.name().substr(0, 10).len() <= 10,
                x.name(),
                x.name().substr(0, 9) ++ '…')
            ).join(' '),
            tags.map(|x| if(
                x.name().substr(0, 10).len() <= 10,
                x.name(),
                x.name().substr(0, 9) ++ '…')
            ).join(' '),
            surround('$description_color', '', if(
                description.first_line().len() <= 24,
                description.first_line(),
                description.first_line().substr(0, 23) ++ '…'
            )),
            if(conflict, '""$conflict_color""conflict'),
            if(divergent, '""$divergent_color""divergent'),
            if(hidden, '""$hidden_color""hidden'),
        )" | string unescape;
        set_color normal
        )
end
