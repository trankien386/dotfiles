#Get confirmation when making rm command
alias -g rm="rm -i"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

# Prompt at bottom of screen - must be loaded before p10k instant prompt
printf '\n%.0s' {1..100}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Install powerlevel10k
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# Save command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=2000
SAVEHIST=1000

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR} ]] ; then
    source ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR}
else
    typeset -g -A key

    [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
    [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
    [[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
    [[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
    [[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
    [[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
    [[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
    [[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
    [[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
    [[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
    [[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
    [[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
    [[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
    [[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
    [[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
    [[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
    [[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
    [[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
    [[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
    [[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
    [[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
    [[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
    [[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
    [[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
    [[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
    [[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
    [[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
    [[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
    [[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
    [[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
    [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search

# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

#Auto CD
setopt AUTO_CD

#Fast Syntax highlighting
source /usr/local/share/fsh/fast-syntax-highlighting.plugin.zsh

#Fzf
[ -f /usr/local/share/fzf/.fzf.zsh ] && source /usr/local/share/fzf/.fzf.zsh

#Fzf Options
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

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden -E 'Library/''

# To apply the command to CTRL-T and ALT-C as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden -E 'Library/'"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1" 'Library/'
}

# FZF colorscheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--color pointer:76,prompt:39,info:215,spinner:203,marker:203
'

#Bat for man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#zsh completion caching
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache
zstyle ':completion:*' cache-path ~/.zsh/cache

#Show current directory on Terminal.app title bar
	# path to my zsh functions folder:
	my_zsh_functions=$repo_dir/dotfiles/zshfunctions/

	# include my zshfunctions dir in fpath:
	if [[ -d $my_zsh_functions ]]; then
    		fpath=( $my_zsh_functions $fpath )
	fi

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Load zmv - better files moving command
autoload -Uz zmv

# Set path for ripgrep config file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Replace Vim with neovim
alias vi="nvim"
alias vim="nvim"

# zsh smart tab completion 
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'

# Bullshit alias
alias bs="bullshit-generator"
alias bullshit='bullshit-generator' 

# No more secrets
alias ls=' ls -AtUhl | nms -as -f yellow'

alias dot='/usr/bin/git --git-dir=/Users/Kien/.dotfiles --work-tree=/Users/Kien'

