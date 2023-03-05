# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# UI
export FZF_DEFAULT_OPTS="
	--height 80%
	
	--border
	--preview-window=:hidden
	--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
	--bind '?:toggle-preview'
	--multi
	--info=inline
	--prompt='⌁ '
	--marker='✗'
	--pointer='➜'	
"

# Colorscheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--color pointer:76,prompt:39,info:215,spinner:203,marker:203
'

# ALT-V - Paste the selected folder path(s) into the command line
fzf-folder-widget() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-}" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  BUFFER="${BUFFER}${(q)dir}"
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
zle     -N             fzf-folder-widget
bindkey -M emacs '\ev' fzf-folder-widget
bindkey -M vicmd '\ev' fzf-folder-widget
bindkey -M viins '\ev' fzf-folder-widget

# Set fd as the default search engine for fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude Library"

# Use fd for Ctrl T command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use fd for Alt C command
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude Library"