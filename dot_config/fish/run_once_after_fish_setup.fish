#!/bin/env fish

# disable greeting
set -U fish_greeting

# set theme
echo y | fish_config theme save tokyonight_storm

# install fisher plugins
if not test -d $fisher_path
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
end

# setup tide prompt
tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Solid --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Few icons' --transient=Yes
set -U tide_left_prompt_items pwd git_disable_if_jj jj newline character
