#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export SUDO_PROMPT="$(tput setaf 1 bold)Please provide your sudo password:$(tput sgr0) "
export CONFDIR="$HOME/arch-hypr-dots/"

source /usr/share/git/completion/git-prompt.sh

PS1="\[\033[1;34m\][\u@\h \W$(__git_ps1 " (%s)")]\$\[\033[0m\] "

alias ls="exa -al --color=always --group-directories-first --icons"     # preferred listing
alias la="exa -a --color=always --group-directories-first --icons"      # all files and dirs
alias ll="exa -l --color=always --group-directories-first --icons"      # long format
alias lt="exa -aT --color=always --group-directories-first --icons"     # tree listing
alias l.="exa -ald --color=always --group-directories-first --icons .*" # show only dotfiles

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias now="date +'  %H:%M:%S %Y/%m/%d'"
alias editHyprConfigs="nvim $HOME/arch-hypr-dots/home/user/.config/hypr/hypr.conf.d/"
alias editShell="nvim $HOMEarch-hypr-dots/home/user/.bashrc.d/"
alias take="sudo chown -R $USER:$USER"
alias pacin="sudo pacman -S --needed"
alias yayin="yay -S --needed"
alias pacFind="pacman -Ss"
alias yayFind="yay -Ss"
alias listAllPkg="pacman -Qqe"
alias savePkgLists="pacman -Qqe | grep -vxF -f <(pacman -Qqm) | grep -v '^yay$' > $HOME/Downloads/official_packages.txt && pacman -Qqm | grep -v '^yay$' > $HOME/Downloads/aur_packages.txt"
alias lastBootLog="journalctl -p 3..4 --boot -o short-monotonic | uniq"
alias startSSH="eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && ssh -T git@github.com"
alias continue="ani-cli --dub -c"
alias watch="ani-cli --dub"
alias off="shutdown -h now"
alias fixPacman="sudo rm /var/lib/pacman/db.lck"
alias wget="wget -c "
alias rmPac="sudo pacman -Rns"
alias rmAur="yay -Rns"
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="ugrep --color=auto"
alias fgrep="ugrep -F --color=auto"
alias egrep="ugrep -E --color=auto"
alias hw="hwinfo --short"                          # Hardware Info
alias gitPkg="pacman -Q | grep -i '\-git' | wc -l" # List amount of -git packages
alias ip="ip -color"
alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias aurUpdates="yay -Qua"
alias pacUpdates="checkupdates"
alias fullUpdate="yay -Syyu && sudo pacman -Syyu"
alias memInfo="free -h --si"
alias diskInfo="df -hT --exclude-type=tmpfs --exclude-type=devtmpfs"
alias cpuInfo="lscpu"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias makeExec="chmod +x"
alias generatePwdLists="$HOME/arch-hypr-dots/home/user/scripts/generatePwdLists.sh"
alias copySrcToDest="$HOME/arch-hypr-dots/home/user/scripts/copySrcToDest.sh"
alias symlink="ln -s"
alias cfg="cd $CONFDIR"

function installOfficialFromList() {
  sudo pacman -S --needed - < "$1"
}

function installAurFromList() {
  yay -S --needed - < "$1"
}

function workon() {
  source "$1/bin/activate"
}

function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1" ;;
      *.tar.gz)    tar xzf "$1" ;;
      *.tar.xz)    tar xJf "$1" ;;
      *.bz2)       bunzip2 "$1" ;;
      *.rar)       unrar x "$1" ;;
      *.gz)        gunzip "$1" ;;
      *.tar)       tar xf "$1" ;;
      *.tbz2)      tar xjf "$1" ;;
      *.tgz)       tar xzf "$1" ;;
      *.zip)       unzip "$1" ;;
      *.7z)        7z x "$1" ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

eval "$(starship init bash)"

fastfetch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

shopt -s expand_aliases

#alias timeshift-gtk="sudo -E timeshift-launcher"
#tarnow="tar -acf "
#alias untar="tar -zxvf "
#alias rmpkg="sudo pacman -Rdd"
#alias grep="grep --color=auto"
