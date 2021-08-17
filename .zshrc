# Look of the Prompt
autoload -U colors && colors
autoload -U vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " - %s(%F{15}%b%f%F{1})%f"
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%B%F{89}[%f%F{10}%n%f%F{11}@%f%F{12}%m%f %F{70}%~%f%F{1}${vcs_info_msg_0_}%f%F{89}]%f%F{15}$%f%b '

# History
HISTFILE=~/.cache/zsh/hist
HISTSIZE=10000
SAVEHIST=10000

# Tab complete
autoload -U compinit
zstyle ':completion:*' menu select
#zstyle :compinstall filename '/home/david/.zshrc'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Plugins
source /etc/profile.d/autojump.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias sudo='sudo '
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias v='nvim'
alias vc='nvim ~/.config/nvim/init.vim'
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -al --color'
alias cleanm='sudo make clean && rm -f config.h && git reset --hard origin/master'
alias upd='sudo pacman -Syu'
alias cl='clear'
alias x="startx"

# Functions
t() {
    (sleep "$1" && notify-send -u critical "$2" "ready!") & disown
}
