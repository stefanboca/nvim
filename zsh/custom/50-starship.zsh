if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
  eval "$(starship completions zsh)"
else
  ZSH_THEME="fedora-plus"
fi
