skip_global_compinit=1

fpath+=("$XDG_CONFIG_HOME/zsh/functions")

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

export EDITOR=vi
