status is-interactive || exit 0

# Tokyo Night Storm theme from https://github.com/folke/tokyonight.nvim/blob/7bb270adaa7692c2c33befc35f5567fc596a2504/extras/fzf/tokyonight_storm.sh
set -gx FZF_DEFAULT_OPTS --cycle --layout=reverse --border --height=-3 --preview-window=wrap --highlight-line --info=inline-right --ansi --color=bg+:#2e3c64 --color=bg:#1f2335 --color=border:#29a4bd --color=fg:#c0caf5 --color=gutter:#1f2335 --color=header:#ff9e64 --color=hl+:#2ac3de --color=hl:#2ac3de --color=info:#545c7e --color=marker:#ff007c --color=pointer:#ff007c --color=prompt:#2ac3de --color=query:#c0caf5:regular --color=scrollbar:#29a4bd --color=separator:#ff9e64 --color=spinner:#ff007c
