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

# Set fd as the default search engine for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden -E 'Library/''

# Apply the command to CTRL-T and ALT-C
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden -E 'Library/'"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1" 'Library/'
}