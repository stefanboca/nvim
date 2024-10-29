if command -v jj >/dev/null; then
  eval "$(fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --shell zsh)"
  eval "$(fnm completions --shell zsh)"
fi
