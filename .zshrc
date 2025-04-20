# ******************* PROMPT *******************
autoload -U vcs_info
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*" formats "%F{10}%r%f%F{3}:%f%F{6}%b%f %S"
precmd() {
  vcs_info
  setopt prompt_subst
  # check if current directory is a git repo
  if [[ -n ${vcs_info_msg_0_} ]] then
    PROMPT="${vcs_info_msg_0_}"$'\n'" %F{4}>%f "
  else
    PROMPT="%B%F{89}[%f%F{10}%n%f%F{11}@%f%F{12}%m%f%F{89}]%f %F{70}%~%f %F{4}%F{15}$%f "
  fi
}
unsetopt prompt_cr prompt_sp

# ******************* HISTORY *******************
HISTFILE=~/.cache/zsh/hist
HISTSIZE=100000
SAVEHIST=100000

# ******************* TAB COMPLETION *******************
autoload -U compinit
zstyle ":completion:*" menu select 
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true
zstyle ':completion:*' hosts off
zstyle ':completion:*:*:git:*' hosts off
#zstyle :compinstall filename "/home/david/.zshrc"
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files
# vim like movement
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history


# ******************* ZOXIDE *******************
eval "$(zoxide init zsh)"

# ******************* VIM *******************
bindkey -v "^?" backward-delete-char
export KEYTIMEOUT=1

# C-e to edit current command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey "^e" edit-command-line

# decrease delay when holding a key
xset r rate 210 40

# ******************* OTHER KEYBINDINGS *******************
bindkey -s "^g" "git status^m"

# ******************* PLUGINS *******************
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
zvm_after_init() { # makes sure fzf works properly with the zsh-vi-mode plugin
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
}

# ******************* ALIASES *******************
alias sudo="sudo"
alias d="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias v="nvim"
alias t="tmux"
alias dv="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim"
alias sv="sudoedit"
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="exa -l -a"
alias lls="exa -l -a --sort=size"
alias cleanm="sudo make clean && rm -f config.h && git reset --hard origin/master"
alias upd="sudo pacman -Syu"
alias upd2="yay -Syu"
alias cl="clear"
alias x="startx"
alias tl="tldr"
alias calc="bc"
alias al="alarm"
alias cya="shutdown now"
alias g="git"
alias gt="git ls-tree -r --name-only HEAD | tree --fromfile"
alias img="sxiv ."
alias cat="bat --paging=never"
alias less="bat --paging=always"
alias sa=". starmarks -a"
alias sj=". starmarks -j"
alias sd=". starmarks -d"
alias nv="/home/david/Code/Git/BuildingRepos/binaries/neovim/bin/nvim"
alias rm="trash"
alias b="buku"
alias l="lazygit"
alias dl="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias tm="btop"
alias p="tmux-repo-opener"
alias reload-compose-key="setxkbmap -option compose:ralt &"
alias cp="cp -n"
alias zsh-stats="cat ~/.cache/zsh/hist | cut -d ' ' -f 2- | awk '{a[\$0]++}END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 50"
alias tablet="otd-daemon &"

# ******************* ADDITIONAL ALIASES *******************
source /home/david/Nextcloud/Main/Further-Dotfiles/config/aliases

# ******************* FUNCTIONS *******************
alarm() {
    echo "When the alarm should go off?"
    echo "(Syntax: <hours> <minutes>)"
    read alarm_hours alarm_minutes

    alarm_string='at now'
    if [ "$alarm_hours" -ne "0" -o "$alarm_minutes" -ne "0" ]; then
      alarm_string="$alarm_string +"
    fi
    if [ "$alarm_hours" -ne "0" ]; then
      alarm_string="$alarm_string $alarm_hours hours"
    fi
    if [ "$alarm_minutes" -ne "0" ]; then
      alarm_string="$alarm_string $alarm_minutes minutes"
    fi

    echo "Name of the alarm?"
    read alarm_name

    cur_seconds=$(date +"%S")
    echo $cur_seconds
    echo "sleep "$cur_seconds" && notify-send -i /home/david/.local/share/icons/alarm.png -u critical "Alarm" "$alarm_name"" | eval "$alarm_string" >/dev/null 2>&1

    notify-send -i /home/david/.local/share/icons/alarm.png -u critical "An alarm for "$alarm_name" was set" "$(date -d "+$alarm_hours hours +$alarm_minutes minutes" +"%H:%M:%S")"
}

n() {
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

git-auth() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github
}

run() {
  local -a args

  setsid "$1" &>/dev/null; exit

}

ts-project() {
  gh repo clone davidk55/js-project-template "$1"
  cd "$1"
  git checkout react-tailwind-typescript
  sudo rm -r .git/
  cd ..
  gh repo create --clone "$1" --public
  cd "$1"
  git branch -m main
}

ts-project-private() {
  gh repo clone davidk55/js-project-template "$1"
  cd "$1"
  git checkout react-tailwind-typescript
  sudo rm -r .git/
  cd ..
  gh repo create --clone "$1" --private
  cd "$1"
  git branch -m main
}

vs() {
  # items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  items=("default" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

cdr(){
  cd $(git rev-parse --show-toplevel)
}


# run showpoke on startup when not in tmux and the terminal is kitty
if [[ $KITTY_INSTALLATION_DIR == "/usr/lib/kitty" ]] && [[ ! $TERM_PROGRAM == "tmux" ]] && [[ ! -v NVIM_LOG_FILE ]]; then
  /home/david/Nextcloud/Main/Further-Dotfiles/scripts/pokemon/showpoke
fi

# add all commands in current path to autocompletion of run
compdef _path_commands run

eval "$(pyenv init -)"

. /usr/share/nvm/init-nvm.sh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
