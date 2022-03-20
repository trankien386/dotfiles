# PROMPT
printf '\n%.0s' {1..100}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# INSTALL POWERLEVEL10K
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# POWERLEVEL10K'S CONFIGURATION FILE
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# AUTO CD
setopt AUTO_CD

# INSTALL FAST SYNTAX HIGHLIGHTING
source ~/.config/fsh/fast-syntax-highlighting.plugin.zsh

# INSTALL FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZSH AUTO COMPLETE:
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+l:|=* r:|=*'
zstyle ':completion:*' use-cache
zstyle ':completion:*' cache-path ~/.cache

# SHARE COMMAND HISTORY ACROSS ZSH SESSIONS
setopt SHARE_HISTORY

# DO NOT STORE DUPLICATIONS
setopt HIST_IGNORE_ALL_DUPS

# ENABLE COLOR FOR LS COMMAND'S OUTPUT
export CLICOLOR=0

# GET CONFIRMATION WHEN MAKING RM COMMAND
alias -g rm="rm -i"

# BARE GIT REPO FOR DOTFILES
alias dot='/usr/bin/git --git-dir=/Users/Kien/.dotfiles --work-tree=/Users/Kien'

# BULLSHIT ALIAS
alias bs="bullshit-generator"

# NO MORE SECRETS
alias ls=' ls -AtUh | nms -as -f yellow'