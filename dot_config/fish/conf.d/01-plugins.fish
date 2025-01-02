set -gx fisher_path $XDG_DATA_HOME/fish/plugins

set -gp fish_complete_path $fisher_path/completions
set -gp fish_function_path $fisher_path/functions

for f in $fisher_path/conf.d/*.fish
    source $f
end
