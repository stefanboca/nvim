set -g fish_complete_path ~/.config/fish_plugins/completions $fish_complete_path
set -g fish_function_path ~/.config/fish_plugins/functions $fish_function_path

for f in ~/.config/fish_plugins/conf.d/*.fish
    source $f
end
