function _tide_item_jj
    if not command -sq jj; or not jj --ignore-working-copy root --quiet &>/dev/null
        return 1
    end

    set -l jj_status (jj log -r@ --ignore-working-copy --no-graph --color always -T '
    separate(" ",
        change_id.shortest(8),
        commit_id.shortest(8),
        bookmarks.map(|x| if(
            x.name().substr(0, 10).starts_with(x.name()),
            x.name().substr(0, 10),
            x.name().substr(0, 9) ++ "…")
        ).join(" "),
        tags.map(|x| if(
            x.name().substr(0, 10).starts_with(x.name()),
            x.name().substr(0, 10),
            x.name().substr(0, 9) ++ "…")
        ).join(" "),
        surround("\"","\"",
            if(
                description.first_line().substr(0, 24).starts_with(description.first_line()),
                description.first_line().substr(0, 24),
                description.first_line().substr(0, 23) ++ "…"
            )
        ),
        if(conflict, "conflict"),
        if(divergent, "divergent"),
        if(hidden, "hidden"),
    )')
    _tide_print_item jj $tide_jj_icon' ' "($jj_status)"
end
