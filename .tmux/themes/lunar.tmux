#!/bin/bash
lunar_black="#16161e"
lunar_green="green"
lunar_blue="blue"
lunar_magenta="magenta"
lunar_cyan="cyan"
lunar_white="#c0caf5"
lunar_visual_grey="#292e42"
lunar_comment_grey="#292e42"
lunar_bg="#1a1b26"
lunar_bg_visual="#2d59a1"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-style" "fg=$lunar_white,bg=$lunar_black"
set "message-command-style" "fg=$lunar_white,bg=$lunar_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-style" "fg=$lunar_black,bg=$lunar_black"
setw "window-status-attr" "none"

setw "window-status-activity-style" "fg=$lunar_black,bg=$lunar_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$lunar_comment_grey"
set "window-active-style" "fg=$lunar_white"

set "display-panes-active-colour" "$lunar_black"
set "display-panes-colour" "$lunar_blue"

set "pane-border-style" "fg=$lunar_white,bg=$lunar_black"
set "pane-active-border-style" "fg=$lunar_green,bg=$lunar_black"

set "status-style" "fg=$lunar_white,bg=$lunar_black"
set "mode-style" "fg=$lunar_bg,bg=$lunar_bg_visual"

set "@prefix_highlight_fg" "$lunar_black"
set "@prefix_highlight_bg" "$lunar_green"
set "@prefix_highlight_copy_mode_attr" "fg=$lunar_black,bg=$lunar_green"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@lunar_widgets")
time_format=$(get "@lunar_time_format" "%R")
date_format=$(get "@lunar_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$lunar_white,bg=$lunar_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$lunar_visual_grey,bg=$lunar_black]#[fg=$lunar_visual_grey,bg=$lunar_visual_grey]#[fg=$lunar_white, bg=$lunar_visual_grey]${status_widgets} #[fg=$lunar_blue,bg=$lunar_visual_grey,nobold,nounderscore,noitalics]#[fg=$lunar_black,bg=$lunar_blue,bold]"
set "status-left" "#[fg=$lunar_black,bg=$lunar_blue,bold] #S #{prefix_highlight}#[fg=$lunar_blue,bg=$lunar_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$lunar_black,bg=$lunar_black,nobold,nounderscore,noitalics]#[fg=$lunar_white,bg=$lunar_black] #I  #W #[fg=$lunar_black,bg=$lunar_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$lunar_black,bg=$lunar_visual_grey,nobold,nounderscore,noitalics]#[fg=$lunar_white,bg=$lunar_visual_grey,nobold] #I  #W #[fg=$lunar_visual_grey,bg=$lunar_black,nobold,nounderscore,noitalics]"
