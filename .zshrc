# zmodload zsh/zprof
source ~/.antigen/antigen.zsh
antigen init ~/.antigenrc

fpath+=${ZDOTDIR:-~}/.zsh_functions
setopt correct

# dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotf="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# lazy load heavy apps
_load_conda() {
   # >>> conda initialize >>>
   # !! Contents within this block are managed by 'conda init' !!
   __conda_setup="$('/home/doctorwho/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
   if [ $? -eq 0 ]; then
       eval "$__conda_setup"
   else
       if [ -f "/home/doctorwho/miniconda3/etc/profile.d/conda.sh" ]; then
           . "/home/doctorwho/miniconda3/etc/profile.d/conda.sh"
       else
           export PATH="/home/doctorwho/miniconda3/bin:$PATH"
       fi
   fi
   unset __conda_setup
}
lazyload conda -- "_load_conda"

# Path appends
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:~/go/bin
# pnpm
export PNPM_HOME="/home/doctorwho/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Other env variables
export EDITOR=lvim
#[ -f "/home/doctorwho/.ghcup/env" ] && source "/home/doctorwho/.ghcup/env" # ghcup-env
# needed for ignition gazebo
export IGN_IP=127.0.0.1
# zprof
