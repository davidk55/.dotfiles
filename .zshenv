# Default Appliactions
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export TERM="alacritty"

# Other Environment Variables
export DOCKER_FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nImage\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"

# nnn
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_PLUG="j:autojump;s:suedit;p:preview-tui;d:dragdrop;i:imgview"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TMPFILE=/tmp/.lastd

# bat (as man page replacement)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# fzf
MY_FD_OPTIONS="fd --color=never --hidden --exclude .git"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard |
                            $MY_FD_OPTIONS --type f"
export FZF_DEFAULT_OPTS="
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
  --height=60%
  --layout=reverse
  --border
  --multi
  --info=inline
  --cycle
"
export FZF_CTRL_T_COMMAND="$MY_FD_OPTIONS --type f"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND="$MY_FD_OPTIONS --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -80'"
