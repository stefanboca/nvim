# zmodload zsh/zprof
source ~/.antigen/antigen.zsh
antigen init ~/.antigenrc

fpath+=${ZDOTDIR:-~}/.zsh_functions
setopt correct

# dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotf="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dotfcp="dotf commit -m\"update\"; dotf push"

# lazy load heavy apps
_load_conda() {
    export CONDA_ROOT="$HOME/.miniconda3"
   _conda_setup="$('$CONDA_ROOT/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
   [ $? -eq 0 ] && eval "$_conda_setup" || [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ] && . "$CONDA_ROOT/etc/profile.d/conda.sh"
}
lazyload conda -- "_load_conda"
lazyload ghc -- "[ -f \"$HOME/.ghcup/env\" ] && source \"$HOME/.ghcup/env\""

# Path appends
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Other env variables
export EDITOR=lvim
# needed for ignition gazebo
export IGN_IP=127.0.0.1

# zprof
