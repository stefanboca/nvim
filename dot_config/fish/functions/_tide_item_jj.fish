function _tide_item_jj
    command -q jj && jj --ignore-working-copy root &>/dev/null || return 1

    _tide_print_item jj $tide_jj_icon' ' (
        jj log -r@ --ignore-working-copy --no-pager --no-graph --color always -T '
        separate(" ",
            change_id.shortest(8),
            commit_id.shortest(8),
            bookmarks.map(|x| if(
                x.name().substr(0, 10).len() <= 10,
                x.name(),
                x.name().substr(0, 9) ++ "…")
            ).join(" "),
            tags.map(|x| if(
                x.name().substr(0, 10).len() <= 10,
                x.name(),
                x.name().substr(0, 9) ++ "…")
            ).join(" "),
            if(
                description.first_line().len() <= 24,
                description.first_line(),
                description.first_line().substr(0, 23) ++ "…"
            ),
            label("conflict", if(conflict, "conflict")),
            label("divergent", if(divergent, "divergent")),
            label("hidden", if(hidden, "hidden")),
        )'
    )
end
