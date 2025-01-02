#!/bin/env fish

tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Solid --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Few icons' --transient=Yes
if not contains jj $tide_right_prompt_items
    set -Ua tide_right_prompt_items jj
end
