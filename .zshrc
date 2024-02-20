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
# source /home/david/.zsh/zsh-vi-mode/zsh-vi-mode.zsh
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
alias cw="curl \"wttr.in/?format=Temperature:+++%t+(feels+like+%f)\nWeather:+++++++%C+%c\nSunrise:+++++++%S\nSunset:++++++++%s\nMoon:++++++++++%m\nUV-Index:++++++%u\n\""
alias reload-compose-key="setxkbmap -option compose:ralt &"
alias cp="cp -n"
alias zsh-stats="cat ~/.cache/zsh/hist | cut -d ' ' -f 2- | awk '{a[\$0]++}END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 50"
alias dc="docker-compose"

# ******************* FUNCTIONS *******************
alarm() {
    setopt verbose
    echo "When the alarm should go off?"
    echo "(Syntax: <hours> <minutes> <seconds>)"
    read alarm_hours alarm_minutes alarm_seconds
    echo "Name of the alarm?"
    read alarm_name
    (sleep "$alarm_hours"h "$alarm_minutes"m "$alarm_seconds"s && notify-send -i /home/david/.local/share/icons/alarm.png -u critical "Alarm" "$alarm_name") & disown
    unsetopt verbose
    notify-send -i /home/david/.local/share/icons/alarm.png -u critical "An alarm was set" "$(date -d "+$alarm_hours hours +$alarm_minutes minutes +$alarm_seconds seconds" +"%H:%M:%S")"
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

tablet() {
  xinput map-to-output $(xinput list | grep stylus | cut -f 2 | cut -c 4-) DP-0
  xsetwacom --set 'HID 256c:006d Pad pad' Button 1 "key alt f3"
  xsetwacom --set 'HID 256c:006d Pad pad' Button 2 "key ctrl z"
  xsetwacom --set 'HID 256c:006d Pad pad' Button 3 "key ctrl shift z"
  xsetwacom --set 'HID 256c:006d Pad pad' Button 8 "key alt f2"
  xsetwacom --set 'HID 256c:006d Pad pad' Button 9 "key f11"
  xsetwacom --set 'HID 256c:006d Pad pad' Button 10 "key alt f4"
  xsetwacom --set 'HID 256c:006d Pen stylus' Button 2 "key alt f5"
  xsetwacom --set 'HID 256c:006d Pen stylus' Button 3 "key alt f1"
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


# run showpoke on startup when not in tmux and the terminal is kitty
if [[ $KITTY_INSTALLATION_DIR == "/usr/lib/kitty" ]] && [[ ! $TERM_PROGRAM == "tmux" ]] && [[ ! -v NVIM_LOG_FILE ]]; then
  /home/david/Nextcloud/Main/Further-Dotfiles/scripts/pokemon/showpoke
fi

# add all commands in current path to autocompletion of run
compdef _path_commands run

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
