# Look of the Prompt
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " - %s($reset_color%b$fg[red])"
precmd() { vcs_info }
setopt prompt_subst
PROMPT='$fg[magenta][$fg[blue]%n$fg[red]@$fg[green]%m $fg[yellow]%~$fg[magenta]]$fg[red]${vcs_info_msg_0_}$reset_color$ '

# History
HISTFILE=~/.cache/zsh/hist
HISTSIZE=1000
SAVEHIST=10000

# Tab complete
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/david/.zshrc'
zmodload zsh/complist
compinit
_comp_options+=(globdots)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Plugins
source ~/.autojump/etc/profile.d/autojump.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
