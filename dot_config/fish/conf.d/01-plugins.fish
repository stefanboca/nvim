set -gx fisher_path $XDG_DATA_HOME/fish/plugins

# put the plugin directories second in the path variables to allow overriding
set -l first_complete_path $fish_complete_path[1]
set fish_complete_path[1] $fisher_path/completions
set -p fish_complete_path $first_complete_path

set -l first_function_path $fish_function_path[1]
set fish_function_path[1] $fisher_path/functions
set -p fish_function_path $first_function_path

for f in $fisher_path/conf.d/*.fish
    source $f
end
