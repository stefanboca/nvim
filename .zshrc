# Path to your oh-my-zsh installation.
export ZSH="/home/doctorwho/.oh-my-zsh"

ZSH_THEME="lukerandall-no-git" # set by `omz`
DEFAULT_USER="doctorwho"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Tmux Plugin Settings
export ZSH_TMUX_AUTOSTART=false  # Automatically starts tmux (default: false)
export ZSH_TMUX_AUTOSTART_ONCE=false    # Autostart only if tmux hasn't been started previously (default: true)
export ZSH_TMUX_AUTOCONNECT=false        # Automatically connect to a previous session if it exits (default: true)
export ZSH_TMUX_AUTOQUIT=false      # Automatically closes terminal once tmux exits (default: ZSH_TMUX_AUTOSTART)
export ZSH_TMUX_UNICODE=true # Set tmux -u option to support unicode
if [[ $VSCODE ]]; then
    export ZSH_TMUX_AUTOSTART=false
fi

plugins=(zsh-vi-mode git docker tmux ubuntu docker-compose git-extras git-lfs systemd wd zsh-autosuggestions alias-tips)

source $ZSH/oh-my-zsh.sh
fpath+=${ZDOTDIR:-~}/.zsh_functions
setopt correct


# User configuration

# dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotf="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# lazy load heavy apps
function lazy_load() {
    local load_fn="$1"
    shift
    local globals=("$@")
    for cmd in "${globals[@]}"; do
        eval "function ${cmd}(){ unset -f ${globals[*]}; ${load_fn}; unset -f ${load_fn}; ${cmd} \$@; }"
    done
}

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
lazy_load "_load_conda" conda

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    _NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
    function _load_nvm() {
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    }
    lazy_load "_load_nvm" "${_NODE_GLOBALS[@]}" node nvm yarn
    unset _NODE_GLOBALS
fi


# Path appends
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:~/go/bin
# pnpm
export PNPM_HOME="/home/doctorwho/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Other env variables
export EDITOR=lvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#[ -f "/home/doctorwho/.ghcup/env" ] && source "/home/doctorwho/.ghcup/env" # ghcup-env
# needed for ignition gazebo
export IGN_IP=127.0.0.1
