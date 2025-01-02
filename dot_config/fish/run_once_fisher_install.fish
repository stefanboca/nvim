#!/bin/env fish

if not test -f $fisher_path
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
end

fisher update
