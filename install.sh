#!/usr/bin/env bash

set -euo pipefail

# Ask for sudo password upfront
sudo -v

# Keep sudo alive until script ends
while true; do
  sudo -n true
  sleep 300
  kill -0 "$$" || exit
done 2>/dev/null &

# Variables

CHECKMARK=$(printf '\u2713')

RESET='\e[0m'

BLUE='\e[34m'
YELLOW='\e[33m'
GREEN='\e[32m'
RED='\e[31m'
TEAL='\e[96m'

BOLD_BLUE='\e[1;34m'
BOLD_YELLOW='\e[1;33m'
BOLD_GREEN='\e[1;32m'
BOLD_RED='\e[1;31m'
BOLD_TEAL='\e[1;96m'

DIM_BLUE='\e[2;34m'
DIM_YELLOW='\e[2;33m'
DIM_GREEN='\e[2;32m'
DIM_RED='\e[2;31m'
DIM_TEAL='\e[2;96m'

DRY_RUN=false
DOTFILES_DIR="$HOME/arch-hypr-dots"
PACMAN_PACKAGES=(
  bash-completion
  bat
  blueman
  btop
  cargo
  cava
  curl
  dosfstools
  expac
  eza
  fastfetch
  fd
  feh
  ffmpeg
  firefox-developer-edition
  fzf
  geany
  geany-plugins
  gimp
  glow
  gnome-disk-utility
  gnome-system-monitor
  go
  gtk4
  gvfs
  htop
  hwinfo
  hyprpicker
  inkscape
  lazygit
  less
  linux-zen-headers
  lynx
  man-db
  mpv
  neovim
  noto-fonts-emoji
  ntfs-3g
  nwg-look
  otf-font-awesome
  patch
  pavucontrol
  pipewire-alsa
  pipewire-pulse
  plymouth
  pulsemixer
  pv
  python-pipx
  python-pynvim
  python-tinycss2
  qbittorrent
  qt5-graphicaleffects
  qt5-quickcontrols2
  qt5-svg
  qt6ct
  qutebrowser
  reflector
  ripgrep
  rsync
  ruby
  rust
  sed
  starship
  swaync
  swww
  syncthing
  termusic
  thunar
  thunar-volman
  tldr
  tmux
  tree
  tumbler
  udiskie
  ugrep
  unrar
  unzip
  waybar
  wev
  wl-clipboard
  wpaperd
  xorg-xcursorgen
  yad
  yt-dlp
)
YAY_PACKAGES=(
  ani-cli
  ani-skip-git
  bluetooth-support
  lobster-git
  plymouth-theme-arch-darwin
  swaylock-effects
  wallust
  wlogout
  ytermusic-bin
)
NVIM_DIRS=(
  "$HOME/.config/nvim"
  "$HOME/.local/share/nvim"
  "$HOME/.local/state/nvim"
  "$HOME/.cache/nvim"
)
NVM_VERSION="v0.40.3"
GEANY_DIRS=(
  "$HOME/.config/geany/colorschemes"
  "$HOME/.config/geany/plugins"
)

# Parse arguments
for arg in "$@"; do
  case $arg in
  --dry-run)
    DRY_RUN=true
    shift
    ;;
  *) ;;
  esac
done

# Execute function

timestamp() { date "+%Y-%m-%d %H:%M:%S"; }

execute() {
  local msg="$1"
  local cmd="$2"
  shift
  printf "${BOLD_BLUE}%s${RESET}\n" "-> $msg @ $(timestamp)"
  if [ "$DRY_RUN" = true ]; then
    printf "%s\n" "   DRY_RUN: $cmd"
  else
    printf "%s\n" "   Executing: $cmd"
    eval "$cmd"
  fi
}

if [ -z "$HOME" ]; then
  echo "ERROR: \$HOME is not set. Aborting... "
  exit 1
fi

# Step 1: Start authentication agent

execute "Starting authentication agent" "/usr/lib/polkit-kde-authentication-agent-1 & sleep 1"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully started authentication agent @ $(timestamp)"

# Step 2: Update system

execute "Updating system packages" "sudo pacman -Syyu --noconfirm"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully updated system packages @ $(timestamp)"

# Step 3: Install pacman packages

pacman_cmd="sudo pacman -S --needed --noconfirm ${PACMAN_PACKAGES[*]}"
execute "Installing packages with pacman" "$pacman_cmd"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed packages with pacman @ $(timestamp)"

# Step 4: Install and update yay

printf "${BOLD_BLUE}%s${RESET}\n" "-> Checking if yay is installed @ $(timestamp)"

if ! command -v yay >/dev/null; then
  printf "${YELLOW}%s${RESET}\n" "-> Could not find yay @ $(timestamp)"
  printf "${BOLD_BLUE}%s${RESET}\n" "-> Checking if Downloads directory exists @ $(timestamp)"

  if [ -d "$HOME/Downloads" ]; then
    # Directory exists
    printf "${TEAL}%s${RESET}\n" "-> Found downloads directory @ $(timestamp)"
  else
    # Directory does not exist
    printf "${YELLOW}%s${RESET}\n" "-> Directory 'Downloads' does not exist @ $(timestamp)"
    execute "Creating Downloads directory" "mkdir -p \"$HOME/Downloads\""
  fi

  execute "Cloning yay repository" "git clone https://aur.archlinux.org/yay.git $HOME/Downloads/yay"
  execute "Navigate to the yay directory" "cd $HOME/Downloads/yay/"
  execute "Building and installing yay" "makepkg -si --noconfirm"
  execute "Navigate back to home directory" "cd $HOME/"
  execute "Cleaning up yay installation files" "rm -rf \"$HOME/Downloads/yay\""
  printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed yay @ $(timestamp)"

else
  printf "${TEAL}%s${RESET}\n" "-> yay already installed @ $(timestamp)"
fi

execute "Updating yay" "yay -Syyu --noconfirm"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully updated yay @ $(timestamp)"

# Step 5: Install yay packages

yay_cmd="yay -S --needed --noconfirm ${YAY_PACKAGES[*]}"
execute "Installing packages with yay" " $yay_cmd"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed packages with yay @ $(timestamp)"

# Step 6: Install Node.js using nvm

printf "${BOLD_BLUE}%s${RESET}\n" "-> Checking if node is installed @ $(timestamp)"

if ! command -v node >/dev/null; then
  printf "${YELLOW}%s${RESET}\n" "-> Could not find node @ $(timestamp)"
  printf "${BOLD_BLUE}%s${RESET}\n" "-> Installing node with nvm"
  execute "Installing nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
  execute "Loading nvm" "source $HOME/.nvm/nvm.sh"
  execute "Installing Node.js v22" "nvm install 22"

  printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed node @ $(timestamp)"
else
  printf "${TEAL}%s${RESET}\n" "-> node already installed @ $(timestamp)"
fi

# # Step 7: Configure Neovim with LazyVim
# printf "%s\n\n" "-> Configuring neovim with lazyvim."
#
# printf "%s\n\n" "-> Checking if nvim configs exists."
#
# for dir in "${NVIM_DIRS[@]}"; do
#   if [ -d "$dir" ]; then
#     # Directory exists
#     execute "Directory '$dir' exists.\nRemoving '$dir'." "rm -rf \"$dir\""
#   else
#     # Directory does not exists
#     printf "%s\n\n" "-> Directory '$dir' does not exist."
#   fi
# done
#
# execute "Cloning LazyVim starter." "git clone https://github.com/LazyVim/starter \"$HOME/.config/nvim\""
# execute "Removing default LazyVim config directory." "rm -rf \"$HOME/.config/nvim/lua\""
# execute "Removing .git directory." "rm -rf \"$HOME/.config/nvim/.git\""
# execute "Symlinking custom Neovim configuration" "ln -sfT $DOTFILES_DIR/home/user/.config/nvim/lua $HOME/.config/nvim/"
#
# printf "%s\n\n" "-> Successfully configured neovim."
#
# # Step 8: Install fonts
#
# printf "%s\n\n" "-> Installing fonts."
# printf "%s\n\n" "-> Checking if fonts directory exists."
#
# if [ -d "$HOME/.local/share/fonts" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating fonts directory." "mkdir -p \"$HOME/.local/share/fonts\""
# fi
#
# execute "Copying JetBrainsMono Nerd Font." "cp -rT $DOTFILES_DIR/home/user/.local/share/fonts/JetBrainsMonoNerdFont $HOME/.local/share/fonts/"
# execute "Refreshing font cache" "fc-cache -f -v"
# printf "%s\n\n" "-> Successfully installing fonts."
#
# # Step 9: Install icons and themes
#
# printf "%s\n\n" "-> Installing icons."
# printf "%s\n\n" "-> Checking if icons directory exists."
#
# if [ -d "$HOME/.icons" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating icons directory." "mkdir -p \"$HOME/.icons\""
# fi
#
# execute "Symlinking Material Black Cherry icon theme." "ln -sfT $DOTFILES_DIR/home/user/.icons/Material_Black_Cherry $HOME/.icons/"
# execute "Symlinking Oreo Red cursor theme." "ln -sfT $DOTFILES_DIR/home/user/.icons/oreo_red_cursor $HOME/.icons/"
# printf "%s\n\n" "-> Successfully installing icons."
#
# printf "%s\n\n" "-> Installing themes."
# printf "%s\n\n" "-> Checking if themes directory exists."
#
# if [ -d "$HOME/.themes" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating themes directory." "mkdir -p \"$HOME/.themes\""
# fi
#
# execute "Symlinking Material Black Cherry GTK theme." "ln -sfT $DOTFILES_DIR/home/user/.themes/Material_Black_Cherry $HOME/.themes/"
# printf "%s\n\n" "-> Successfully installing themes."
#
# # Step 10: Symlink configurations
#
# printf "%s\n\n" "-> Starting package configurations..."
#
# #Bash
# printf "%s\n\n" "-> Configuring bash..."
# execute "Removing default .bashrc file." "rm -rf \"$HOME/.bashrc\""
# execute "Symlinking new .bashrc file." "ln -sf $DOTFILES_DIR/home/user/.bashrc $HOME/.bashrc"
# execute "Symlinking scripts directory." "ln -sfT $DOTFILES_DIR/home/user/scripts $HOME/"
# printf "%s\n\n" "-> Successfully configured bash."
#
# #Ani-cli
# printf "%s\n\n" "-> Configuring ani-cli..."
# printf "%s\n\n" "-> Checking if ani-cli directory exists."
#
# if [ -d "$HOME/.local/state/ani-cli" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if ani-hist exists."
#   if [ -f "$HOME/.local/state/ani-cli/ani-hist" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default ani-hist file." "rm -rf \"$HOME/.local/state/ani-cli/ani-hist\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating ani-cli directory." "mkdir -p \"$HOME/.local/state/ani-cli\""
# fi
#
# execute "Symlinking ani-hist file." "ln -sf $DOTFILES_DIR/home/user/.local/state/ani-cli/ani-hist $HOME/.local/state/ani-cli/"
# execute "Symlinking anicli-continue script." "ln -sf $DOTFILES_DIR/home/user/anicli-continue.sh $HOME/"
# execute "Symlinking anicli-watch script." "ln -sf $DOTFILES_DIR/home/user/anicli-watch.sh $HOME/"
# printf "%s\n\n" "-> Successfully configured ani-cli."
#
# #Fastfetch
# printf "%s\n\n" "-> Configuring fastfetch..."
# execute "Symlinking fastfetch directory." "ln -sfT $DOTFILES_DIR/home/user/.config/fastfetch $HOME/.config/"
# printf "%s\n\n" "-> Successfully configured fastfetch."
#
# #Feather
# printf "%s\n\n" "-> Configuring Feather..."
# printf "%s\n\n" "-> Checking if Feather directory exists."
#
# if [ -d "$HOME/.config/Feather" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default Feather directory." "rm -rf \"$HOME/.config/Feather\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking Feather directory." "ln -sfT $DOTFILES_DIR/home/user/.config/Feather $HOME/.config/"
# execute "Symlinking feather script." "ln -sf $DOTFILES_DIR/home/user/feather_cava_tmux.sh $HOME/"
# printf "%s\n\n" "-> Successfully configured Feather."
#
# #Geany
# printf "%s\n\n" "-> Configuring geany..."
# printf "%s\n\n" "-> Checking if geany directory exists."
#
# if [ -d "$HOME/.config/geany" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default geany.conf file" "rm -rf \"$HOME/.config/geany/geany.conf\""
#   for dir in "${GEANY_DIRS[@]}"; do
#     printf "%s\n\n" "-> Checking if '$dir' exists."
#     if [ -d "$dir" ]; then
#       # Directory exists
#       execute "Directory '$dir' exists.\nRemoving '$dir'." "rm -rf \"$dir\""
#     else
#       # Directory does not exists
#       printf "%s\n\n" "-> Directory '$dir' does not exist."
#     fi
#   done
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking geany.conf file." "ln -sf $DOTFILES_DIR/home/user/.config/geany/geany.conf $HOME/.config/geany/"
# execute "Symlinking colorschemes directory." "ln -sfT $DOTFILES_DIR/home/user/.config/geany/colorschemes $HOME/.config/geany/"
# execute "Symlinking plugins directory." "ln -sfT $DOTFILES_DIR/home/user/.config/geany/plugins $HOME/.config/geany/"
# printf "%s\n\n" "-> Successfully configured geany."
#
# #Hyprland
# printf "%s\n\n" "-> Configuring hyprland..."
# execute "Removing default hyprland.conf file." "rm -rf \"$HOME/.config/hypr/hyprland.conf\""
# execute "Symlinking new hyprland.conf file." "ln -sf $DOTFILES_DIR/home/user/.config/hypr/hyprland.conf $HOME/.config/hypr/"
# printf "%s\n\n" "-> Successfully configured hyprland."
#
# #Kitty
# printf "%s\n\n" "-> Configuring kitty..."
# printf "%s\n\n" "-> Checking if kitty directory exists."
#
# if [ -d "$HOME/.config/kitty" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default kitty directory." "rm -rf \"$HOME/.config/kitty\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking kitty directory." "ln -sfT $DOTFILES_DIR/home/user/.config/kitty $HOME/.config/"
#
# printf "%s\n\n" "-> Checking if applications directory exists."
#
# if [ -d "$HOME/.local/share/applications" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if kitty.desktop exists."
#   if [ -f "$HOME/.local/share/applications/kitty.desktop" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default kitty.desktop file." "rm -rf \"$HOME/.local/share/applications/kitty.desktop\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating applications directory." "mkdir -p \"$HOME/.local/share/applications\""
# fi
#
# execute "Symlinking kitty.desktop file." "ln -sf $DOTFILES_DIR/home/user/.local/share/applications/kitty.desktop $HOME/.local/share/applications/"
# execute "Updating desktop database" "update-desktop-database /home/$USER/.local/share/applications"
# printf "%s\n\n" "-> Successfully configured kitty."
#
# #Mpv
# printf "%s\n\n" "-> Configuring mpv..."
# printf "%s\n\n" "-> Checking if mpv directory exists."
#
# if [ -d "$HOME/.config/mpv" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if mpv.conf exists."
#   if [ -f "$HOME/.config/mpv/mpv.conf" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default mpv.conf file." "rm -rf \"$HOME/.config/mpv/mpv.conf\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating mpv directory." "mkdir -p \"$HOME/.config/mpv\""
# fi
#
# execute "Symlinking mpv.conf file." "ln -sf $DOTFILES_DIR/home/user/.config/mpv/mpv.conf $HOME/.config/mpv/"
# printf "%s\n\n" "-> Successfully configured mpv."
#
# #Plymouth
# printf "%s\n\n" "-> Configuring plymouth..."
# printf "%s\n\n" "-> Checking if cmdline.d directory exists."
#
# if [ -d "/etc/cmdline.d" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if arch.conf exists."
#   if [ -f "/etc/cmdline.d/arch.conf" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default arch.conf file." "sudo rm -rf \"/etc/cmdline.d/arch.conf\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating cmdline.d directory." "sudo mkdir -p \"/etc/cmdline.d\""
# fi
#
# execute "Creating blank arch.conf file." "sudo touch /etc/cmdline.d/arch.conf"
# execute "Setting kernel parameters for Plymouth" "printf 'options $(cat /etc/kernel/cmdline) quiet splash' | sudo tee /etc/cmdline.d/arch.conf"
# execute "Setting Plymouth theme to arch-darwin" "sudo plymouth-set-default-theme -R arch-darwin"
# printf "%s\n\n" "-> Successfully configured plymouth."
#
# #Qutebrowser
# printf "%s\n\n" "-> Configuring qutebrowser..."
# printf "%s\n\n" "-> Checking if qutebrowser directory exists."
#
# if [ -d "$HOME/.config/qutebrowser" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if config.py exists."
#   if [ -f "$HOME/.config/qutebrowser/config.py" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default config.py file." "rm -rf \"$HOME/.config/qutebrowser/config.py\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating qutebrowser directory." "mkdir -p \"$HOME/.config/qutebrowser\""
# fi
#
# execute "Symlinking config.py file." "ln -sf $DOTFILES_DIR/home/user/.config/qutebrowser/config.py $HOME/.config/qutebrowser/"
#
# printf "%s\n\n" "-> Checking if qutebrowser themes directory exists."
#
# if [ -d "$HOME/.config/qutebrowser/themes" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Copying onedark.py." "cp $DOTFILES_DIR/home/user/.config/qutebrowser/themes/onedark.py $HOME/.config/qutebrowser/themes/"
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
# execute "Copying themes directory." "cp -rT $DOTFILES_DIR/home/user/.config/qutebrowser/themes $HOME/.config/qutebrowser/"
# printf "%s\n\n" "-> Successfully configured qutebrowser."
#
# #SDDM
# printf "%s\n\n" "-> Configuring SDDM..."
# printf "%s\n\n" "-> Checking if sddm.conf.d directory exists."
#
# if [ -d "/etc/sddm.conf.d" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if sddm.conf exists."
#   if [ -f "/etc/sddm.conf.d/sddm.conf" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default sddm.conf file." "sudo rm -rf \"/etc/sddm.conf.d/sddm.conf\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating sddm.conf.d directory." "sudo mkdir -p \"/etc/sddm.conf.d\""
# fi
#
# execute "Creating blank sddm.conf file." "sudo touch /etc/sddm.conf.d/sddm.conf"
# execute "Writing SDDM configuration" "printf '[General]\nNumlock=on\n\n[Theme]\nCurrent=sugar-dark' | sudo tee /etc/sddm.conf.d/sddm.conf"
#
# printf "%s\n\n" "-> Checking if sddm directory exists."
#
# if [ -d "/usr/share/sddm" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> sddm directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating sddm directory." "sudo mkdir -p \"/usr/share/sddm/\""
# fi
#
# printf "%s\n\n" "-> Checking if sddm themes directory exists."
#
# if [ -d "/usr/share/sddm/themes" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating sddm themes directory." "sudo mkdir -p \"/usr/share/sddm/themes\""
# fi
#
# execute "Copying sugar-dark theme to SDDM themes directory" "sudo cp -rT $DOTFILES_DIR/usr/share/sddm/themes/sugar-dark /usr/share/sddm/themes/"
# printf "%s\n\n" "-> Successfully configured SDDM."
#
# #Starship
# printf "%s\n\n" "-> Configuring starship..."
# execute "Symlinking starship.toml file." "ln -sf $DOTFILES_DIR/home/user/.config/starship.toml $HOME/.config/"
# printf "%s\n\n" "-> Successfully configured starship."
#
# #swaylock-effects
# printf "%s\n\n" "-> Configuring swaylock-effects..."
# printf "%s\n\n" "-> Checking if swaylock directory exists."
#
# if [ -d "$HOME/.config/swaylock" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default swaylock directory." "rm -rf \"$HOME/.config/swaylock\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking swaylock directory." "ln -sfT $DOTFILES_DIR/home/user/.config/swaylock $HOME/.config/"
# printf "%s\n\n" "-> Successfully configured swaylock-effects."
#
# #Thunar
# printf "%s\n\n" "-> Configuring thunar..."
# printf "%s\n\n" "-> Checking if xfce4 directory exists in '~/.config/'."
#
# if [ -d "$HOME/.config/xfce4" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if helpers.rc exists."
#   if [ -f "$HOME/.config/xfce4/helpers.rc" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default helpers.rc file." "rm -rf \"$HOME/.config/xfce4/helpers.rc\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating xfce4 directory in \"~/.config/\"." "mkdir -p \"$HOME/.config/xfce4\""
# fi
#
# printf "%s\n\n" "-> Checking if xfce4 directory exists in '~/.local/share/'."
#
# if [ -d "$HOME/.local/share/xfce4" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> xfce4 directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating xfce4 directory in \"~/.local/share/\"." "mkdir -p \"$HOME/.local/share/xfce4\""
# fi
#
# printf "%s\n\n" "-> Checking if helpers directory exists in '~/.local/share/xfce4/'."
#
# if [ -d "$HOME/.local/share/xfce4/helpers" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   printf "%s\n\n" "-> Checking if kitty.desktop exists."
#   if [ -f "$HOME/.local/share/xfce4/helpers/kitty.desktop" ]; then
#     # File exists
#     printf "%s\n\n" "-> File exists."
#     execute "Removing default kitty.desktop file." "rm -rf \"$HOME/.local/share/xfce4/helpers/kitty.desktop\""
#   fi
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating helpers directory." "mkdir -p \"$HOME/.local/share/xfce4/helpers\""
# fi
#
# execute "Symlinking kitty.desktop file." "ln -sf $DOTFILES_DIR/home/user/.local/share/xfce4/helpers/kitty.desktop $HOME/.local/share/xfce4/helpers/"
# execute "Symlinking helpers.rc file." "ln -sf $DOTFILES_DIR/home/user/.config/xfce4/helpers.rc $HOME/.config/xfce4/"
# printf "%s\n\n" "-> Successfully configured thunar."
#
# #Tmux
# printf "%s\n\n" "-> Configuring tmux..."
# execute "Symlinking .tmux directory." "ln -sfT $DOTFILES_DIR/home/user/.tmux $HOME/"
# execute "Symlinking .tmux.conf file." "ln -sf $DOTFILES_DIR/home/user/.tmux.conf $HOME/"
# printf "%s\n\n" "-> Successfully configured tmux."
#
# #Waybar
# printf "%s\n\n" "-> Configuring waybar..."
# printf "%s\n\n" "-> Checking if waybar directory exists."
#
# if [ -d "$HOME/.config/waybar" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default waybar directory." "rm -rf \"$HOME/.config/waybar\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking waybar directory." "ln -sfT $DOTFILES_DIR/home/user/.config/waybar $HOME/.config/"
# printf "%s\n\n" "-> Successfully configured waybar."
#
# #Wlogout
#
# printf "%s\n\n" "-> Configuring wlogout..."
# printf "%s\n\n" "-> Checking if wlogout directory exists in '/usr/share/'."
#
# if [ -d "/usr/share/wlogout" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
#   execute "Creating wlogout directory in \"/usr/share/\"." "sudo mkdir -p \"/usr/share/wlogout\""
# fi
#
# execute "Copying icons to '/usr/share/wlogout/" "sudo cp -rT $DOTFILES_DIR/usr/share/wlogout/icons /usr/share/wlogout/"
#
# printf "%s\n\n" "-> Checking if wlogout directory exists in '~/.config/'."
#
# if [ -d "$HOME/.config/wlogout" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> wlogout directory exists."
#   execute "Removing default wlogout directory." "rm -rf \"$HOME/.config/wlogout\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking wlogout directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wlogout $HOME/.config/"
# printf "%s\n\n" "-> Successfully configured wlogout."
#
# #Wpaperd
# printf "%s\n\n" "-> Configuring wpaperd..."
# printf "%s\n\n" "-> Checking if wpaperd directory exists."
#
# if [ -d "$HOME/.config/wpaperd" ]; then
#   # Directory exists
#   printf "%s\n\n" "-> Directory exists."
#   execute "Removing default wpaperd directory." "rm -rf \"$HOME/.config/wpaperd\""
# else
#   # Directory does not exist
#   printf "%s\n\n" "-> Directory does not exist."
# fi
#
# execute "Symlinking wpaperd directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wpaperd $HOME/.config/"
# execute "Symlinking wallpapers directory." "ln -sfT $DOTFILES_DIR/home/user/wallpapers $HOME/"
# printf "%s\n\n" "-> Successfully configured wpaperd."
# printf "%s\n\n" "-> Completed package configurations."
#
# # Step 11: Final message
# printf "\n Setup complete. Please complete the 'Manual intervention' section on from the README.md, then reboot your system to apply all changes."
