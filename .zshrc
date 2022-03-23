# Look of the Prompt
autoload -U colors && colors
autoload -U vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " - %s(%F{15}%b%f%F{1})%f"
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%B%F{89}[%f%F{10}%n%f%F{11}@%f%F{12}%m%f %F{70}%~%f%F{1}${vcs_info_msg_0_}%f%F{89}]%f%F{15}$%f%b '
unsetopt prompt_cr prompt_sp

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
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# C-e to edit current command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Plugins
source /etc/profile.d/autojump.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias sudo='sudo '
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias v='nvim'
alias vc='nvim ~/.config/nvim/init.vim'
alias barev='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim'
alias barevc='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim ~/.config/nvim/init.vim'
alias sv='sudoedit'
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -al --color'
alias cleanm='sudo make clean && rm -f config.h && git reset --hard origin/master'
alias upd='sudo pacman -Syu'
alias cl='clear'
alias x="startx"
alias tl="tldr"
alias calc="bc"

# Functions
t() {
    (sleep "$1" && notify-send -u critical "$2" "ready!") & disown
}
sc() {
  (maim -s -o ~/Documents/Screenshots/screenshot--$(date -u +"%Y-%m-%d--%H-%M-%S"))
}

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -e "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
