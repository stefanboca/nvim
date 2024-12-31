set -gp fish_complete_path ~/.config/fish_plugins/completions
set -gp fish_function_path ~/.config/fish_plugins/functions

for f in ~/.config/fish_plugins/conf.d/*.fish
    source $f
end
