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
  mpv
  neovim
  noto-fonts-emoji
  ntfs-3g
  nwg-look
  otf-font-awesome
  patch
  pavucontrol
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
  shift
  printf "\n$(timestamp) -> $msg\n"
  if [ "$DRY_RUN" = true ]; then
    echo "DRY RUN: $*"
  else
    eval "$@"
  fi
}

if [ -z "$HOME" ]; then
  echo "ERROR: \$HOME is not set. Aborting."
  exit 1
fi

# Step 1: Start authentication agent

execute "Starting authentication agent." "/usr/lib/polkit-kde-authentication-agent-1 &"

# Step 2: Update system

execute "Updating system packages." "sudo pacman -Syyu --noconfirm"

# Step 3: Install pacman packages

execute "Installing packages with pacman." "sudo pacman -S --needed --noconfirm ${PACMAN_PACKAGES[@]}"

# Step 4: Install and update yay

if ! command -v yay >/dev/null; then
  printf "\n-> Checking if Downloads directory exists."

  if [ -d "$HOME/Downloads" ]; then
    # Directory exists
    printf "\n-> Directory exists."
  else
    # Directory does not exist
    printf "\n-> Directory does not exist."
    execute "Creating Downloads directory." "mkdir -p \"$HOME/Downloads\""
  fi

  execute "Cloning yay repository." "git clone https://aur.archlinux.org/yay.git $HOME/Downloads/yay"
  execute "Building and installing yay." "cd $HOME/Downloads/yay && makepkg -si --noconfirm"
  execute "Cleaning up yay installation files." "cd $HOME && rm -rf \"$HOME/Downloads/yay\""
else
  printf "\n-> yay already installed."
fi

execute "Updating packages with yay." "yay -Syyu --noconfirm"

# Step 5: Install yay packages

execute "Installing packages with yay." "yay -S --needed --noconfirm ${YAY_PACKAGES[@]}"

# Step 6: Install Node.js using nvm

execute "Installing nvm." "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/\"$NVM_VERSION\"/install.sh | bash"

execute "Loading nvm." "source $HOME/.nvm/nvm.sh"
execute "Installing Node.js v22." "nvm install 22"

# Step 7: Configure Neovim with LazyVim

printf "\n-> Checking if nvim configs exists."

for dir in "${NVIM_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    # Directory exists
    execute "Directory '$dir' exists.\nRemoving '$dir'." "rm -rf \"$dir\""
  else
    # Directory does not exists
    printf "\n-> Directory '$dir' does not exist."
  fi
done

execute "Cloning LazyVim starter." "git clone https://github.com/LazyVim/starter $HOME/.config/nvim"
execute "Removing default LazyVim config and .git directory." "rm -rf \"$HOME/.config/nvim/lua $HOME/.config/nvim/.git\""
execute "Symlinking custom Neovim configuration" "ln -sfT $DOTFILES_DIR/home/user/.config/nvim/lua $HOME/.config/nvim/"

# Step 8: Install fonts

printf "\n-> Checking if fonts directory exists."

if [ -d "$HOME/.local/share/fonts" ]; then
  # Directory exists
  printf "\n-> Directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating fonts directory." "mkdir -p \"$HOME/.local/share/fonts\""
fi

execute "Copying JetBrainsMono Nerd Font." "cp -rT $DOTFILES_DIR/home/user/.local/share/fonts/JetBrainsMonoNerdFont $HOME/.local/share/fonts/"
execute "Refreshing font cache" "fc-cache -f -v"

# Step 9: Install icons and themes

printf "\n-> Checking if icons directory exists."

if [ -d "$HOME/.icons" ]; then
  # Directory exists
  printf "\n-> Directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating icons directory." "mkdir -p \"$HOME/.icons\""
fi

execute "Symlinking Material Black Cherry icon theme." "ln -sfT $DOTFILES_DIR/home/user/.icons/Material_Black_Cherry $HOME/.icons/"
execute "Symlinking Oreo Red cursor theme." "ln -sfT $DOTFILES_DIR/home/user/.icons/oreo_red_cursor $HOME/.icons/"

printf "\n-> Checking if themes directory exists."

if [ -d "$HOME/.themes" ]; then
  # Directory exists
  printf "\n-> Directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating themes directory." "mkdir -p \"$HOME/.themes\""
fi

execute "Symlinking Material Black Cherry GTK theme." "ln -sfT $DOTFILES_DIR/home/user/.themes/Material_Black_Cherry $HOME/.themes/"

# Step 10: Symlink configurations

printf "\n-> Starting package configurations..."

#Bash
printf "\n-> Configuring bash..."
execute "Removing default .bashrc file." "rm -rf \"$HOME/.bashrc\""
execute "Symlinking new .bashrc file." "ln -sfT $DOTFILES_DIR/home/user/.bashrc $HOME/.bashrc"
execute "Symlinking scripts directory." "ln -sfT $DOTFILES_DIR/home/user/scripts $HOME/"
printf "\n-> Successfully configured bash."

#Ani-cli
printf "\n-> Configuring ani-cli..."
printf "\n-> Checking if ani-cli directory exists."

if [ -d "$HOME/.local/state/ani-cli" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if ani-hist exists."
  if [ -f "$HOME/.local/state/ani-cli/ani-hist" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default ani-hist file." "rm -rf \"$HOME/.local/state/ani-cli/ani-hist\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating ani-cli directory." "mkdir -p \"$HOME/.local/state/ani-cli\""
fi

execute "Symlinking ani-hist file." "ln -sfT $DOTFILES_DIR/home/user/.local/state/ani-cli/ani-hist $HOME/.local/state/ani-cli/"
printf "\n-> Successfully configured ani-cli."

#Fastfetch
printf "\n-> Configuring fastfetch..."
execute "Symlinking fastfetch directory." "ln -sfT $DOTFILES_DIR/home/user/.config/fastfetch $HOME/.config/"
printf "\n-> Successfully configured fastfetch."

#Feather
printf "\n-> Configuring Feather..."
printf "\n-> Checking if Feather directory exists."

if [ -d "$HOME/.config/Feather" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default Feather directory." "rm -rf \"$HOME/.config/Feather\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking Feather directory." "ln -sfT $DOTFILES_DIR/home/user/.config/Feather $HOME/.config/"
execute "Symlinking feather_cava_tmux.sh." "ln -sfT $DOTFILES_DIR/home/user/feather_cava_tmux.sh $HOME/"
printf "\n-> Successfully configured Feather."

#Geany
printf "\n-> Configuring geany..."
printf "\n-> Checking if geany directory exists."

if [ -d "$HOME/.config/geany" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default geany.conf file" "rm -rf \"$HOME/.config/geany/geany.conf\""
  for dir in "${GEANY_DIRS[@]}"; do
    printf "\n-> Checking if '$dir' exists."
    if [ -d "$dir" ]; then
      # Directory exists
      execute "Directory '$dir' exists.\nRemoving '$dir'." "rm -rf \"$dir\""
    else
      # Directory does not exists
      printf "\n-> Directory '$dir' does not exist."
    fi
  done
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking geany.conf file." "ln -sfT $DOTFILES_DIR/home/user/.config/geany/geany.conf $HOME/.config/geany/"
execute "Symlinking colorschemes directory." "ln -sfT $DOTFILES_DIR/home/user/.config/geany/colorschemes $HOME/.config/geany/"
execute "Symlinking plugins directory." "ln -sfT $DOTFILES_DIR/home/user/.config/geany/plugins $HOME/.config/geany/"
printf "\n-> Successfully configured geany."

#Hyprland
printf "\n-> Configuring hyprland..."
execute "Removing default hyprland.conf file." "rm -rf \"$HOME/.config/hypr/hyprland.conf\""
execute "Symlinking new hyprland.conf file." "ln -sfT $DOTFILES_DIR/home/user/.config/hypr/hyprland.conf $HOME/.config/hypr/"
printf "\n-> Successfully configured hyprland."

#Kitty
printf "\n-> Configuring kitty..."
printf "\n-> Checking if kitty directory exists."

if [ -d "$HOME/.config/kitty" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default kitty directory." "rm -rf \"$HOME/.config/kitty\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking kitty directory." "ln -sfT $DOTFILES_DIR/home/user/.config/kitty $HOME/.config/"

printf "\n-> Checking if applications directory exists."

if [ -d "$HOME/.local/share/applications" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if kitty.desktop exists."
  if [ -f "$HOME/.local/share/applications/kitty.desktop" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default kitty.desktop file." "rm -rf \"$HOME/.local/share/applications/kitty.desktop\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating applications directory." "mkdir -p \"$HOME/.local/share/applications\""
fi

execute "Symlinking kitty.desktop file." "ln -sfT $DOTFILES_DIR/home/user/.local/share/applications/kitty.desktop $HOME/.local/share/applications/"
execute "Updating desktop database" "update-desktop-database /home/$USER/.local/share/applications"
printf "\n-> Successfully configured kitty."

#Plymouth
printf "\n-> Configuring plymouth..."
printf "\n-> Checking if cmdline.d directory exists."

if [ -d "/etc/cmdline.d" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if arch.conf exists."
  if [ -f "/etc/cmdline.d/arch.conf" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default arch.conf file." "sudo rm -rf \"/etc/cmdline.d/arch.conf\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating cmdline.d directory." "mkdir -p \"/etc/cmdline.d\""
fi

execute "Creating blank arch.conf file." "sudo touch /etc/cmdline.d/arch.conf"
execute "Setting kernel parameters for Plymouth" "printf 'options $(cat /etc/kernel/cmdline) quiet splash' | sudo tee /etc/cmdline.d/arch.conf"
execute "Setting Plymouth theme to arch-darwin" "sudo plymouth-set-default-theme -R arch-darwin"
printf "\n-> Successfully configured plymouth."

#Qutebrowser
printf "\n-> Configuring qutebrowser..."
printf "\n-> Checking if qutebrowser directory exists."

if [ -d "$HOME/.config/qutebrowser" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if config.py exists."
  if [ -f "$HOME/.config/qutebrowser/config.py" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default config.py file." "rm -rf \"$HOME/.config/qutebrowser/config.py\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating qutebrowser directory." "mkdir -p \"$HOME/.config/qutebrowser\""
fi

execute "Symlinking config.py file." "ln -sfT $DOTFILES_DIR/home/user/.config/qutebrowser/config.py $HOME/.config/qutebrowser/"

printf "\n-> Checking if qutebrowser themes directory exists."

if [ -d "$HOME/.config/qutebrowser/themes" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Copying onedark.py." "cp $DOTFILES_DIR/home/user/.config/qutebrowser/themes/onedark.py $HOME/.config/qutebrowser/themes/"
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi
execute "Copying themes directory." "cp -rT $DOTFILES_DIR/home/user/.config/qutebrowser/themes $HOME/.config/qutebrowser/"
printf "\n-> Successfully configured qutebrowser."

#SDDM
printf "\n-> Configuring SDDM..."
printf "\n-> Checking if sddm.conf.d directory exists."

if [ -d "/etc/sddm.conf.d" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if sddm.conf exists."
  if [ -f "/etc/sddm.conf.d/sddm.conf" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default sddm.conf file." "sudo rm -rf \"/etc/sddm.conf.d/sddm.conf\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating sddm.conf.d directory." "sudo mkdir -p \"/etc/sddm.conf.d\""
fi

execute "Creating blank sddm.conf file." "sudo touch /etc/sddm.conf.d/sddm.conf"
execute "Writing SDDM configuration" "printf '[General]\nNumlock=on\n\n[Theme]\nCurrent=sugar-dark' | sudo tee /etc/sddm.conf.d/sddm.conf"

printf "\n-> Checking if sddm directory exists."

if [ -d "/usr/share/sddm" ]; then
  # Directory exists
  printf "\n-> sddm directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating sddm directory." "sudo mkdir -p \"/usr/share/sddm/\""
fi

printf "\n-> Checking if sddm themes directory exists."

if [ -d "/usr/share/sddm/themes" ]; then
  # Directory exists
  printf "\n-> Directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating sddm themes directory." "sudo mkdir -p \"/usr/share/sddm/themes\""
fi

execute "Copying sugar-dark theme to SDDM themes directory" "sudo cp -rT $DOTFILES_DIR/usr/share/sddm/themes/sugar-dark /usr/share/sddm/themes/"
printf "\n-> Successfully configured SDDM."

#Starship
printf "\n-> Configuring starship..."
execute "Symlinking starship.toml file." "ln -sfT $DOTFILES_DIR/home/user/.config/starship.toml $HOME/.config/"
printf "\n-> Successfully configured starship."

#swaylock-effects
printf "\n-> Configuring swaylock-effects..."
printf "\n-> Checking if swaylock directory exists."

if [ -d "$HOME/.config/swaylock" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default swaylock directory." "rm -rf \"$HOME/.config/swaylock\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking swaylock directory." "ln -sfT $DOTFILES_DIR/home/user/.config/swaylock $HOME/.config/"
printf "\n-> Successfully configured swaylock-effects."

#Thunar
printf "\n-> Configuring thunar..."
printf "\n-> Checking if xfce4 directory exists in '~/.config/'."

if [ -d "$HOME/.config/xfce4" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if helpers.rc exists."
  if [ -f "$HOME/.config/xfce4/helpers.rc" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default helpers.rc file." "rm -rf \"$HOME/.config/xfce4/helpers.rc\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating xfce4 directory in \"~/.config/\"." "mkdir -p \"$HOME/.config/xfce4\""
fi

printf "\n-> Checking if xfce4 directory exists in '~/.local/share/'."

if [ -d "$HOME/.local/share/xfce4" ]; then
  # Directory exists
  printf "\n-> xfce4 directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating xfce4 directory in \"~/.local/share/\"." "mkdir -p \"$HOME/.local/share/xfce4\""
fi

printf "\n-> Checking if helpers directory exists in '~/.local/share/xfce4/'."

if [ -d "$HOME/.local/share/xfce4/helpers" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  printf "\n-> Checking if kitty.desktop exists."
  if [ -f "$HOME/.local/share/xfce4/helpers/kitty.desktop" ]; then
    # File exists
    printf "\n-> File exists."
    execute "Removing default kitty.desktop file." "rm -rf \"$HOME/.local/share/xfce4/helpers/kitty.desktop\""
  fi
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating helpers directory." "mkdir -p \"$HOME/.local/share/xfce4/helpers\""
fi

execute "Symlinking kitty.desktop file." "ln -sfT $DOTFILES_DIR/home/user/.local/share/xfce4/helpers/kitty.desktop $HOME/.local/share/xfce4/helpers/"
execute "Symlinking helpers.rc file." "ln -sfT $DOTFILES_DIR/home/user/.config/xfce4/helpers.rc $HOME/.config/xfce4/"
printf "\n-> Successfully configured thunar."

#Tmux
printf "\n-> Configuring tmux..."
execute "Symlinking .tmux directory." "ln -sfT $DOTFILES_DIR/home/user/.tmux $HOME/"
execute "Symlinking .tmux.conf file." "ln -sfT $DOTFILES_DIR/home/user/.tmux.conf $HOME/"
printf "\n-> Successfully configured tmux."

#Waybar
printf "\n-> Configuring waybar..."
printf "\n-> Checking if waybar directory exists."

if [ -d "$HOME/.config/waybar" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default waybar directory." "rm -rf \"$HOME/.config/waybar\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking waybar directory." "ln -sfT $DOTFILES_DIR/home/user/.config/waybar $HOME/.config/"
printf "\n-> Successfully configured waybar."

#Wlogout

printf "\n-> Configuring wlogout..."
printf "\n-> Checking if wlogout directory exists in '/usr/share/'."

if [ -d "/usr/share/wlogout" ]; then
  # Directory exists
  printf "\n-> Directory exists."
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
  execute "Creating wlogout directory in \"/usr/share/\"." "sudo mkdir -p \"/usr/share/wlogout\""
fi

execute "Copying icons to '/usr/share/wlogout/" "sudo cp -rT $DOTFILES_DIR/usr/share/wlogout/icons /usr/share/wlogout/"

printf "\n-> Checking if wlogout directory exists in '~/.config/'."

if [ -d "$HOME/.config/wlogout" ]; then
  # Directory exists
  printf "\n-> wlogout directory exists."
  execute "Removing default wlogout directory." "rm -rf \"$HOME/.config/wlogout\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking wlogout directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wlogout $HOME/.config/"
printf "\n-> Successfully configured wlogout."

#Wpaperd
printf "\n-> Configuring wpaperd..."
printf "\n-> Checking if wpaperd directory exists."

if [ -d "$HOME/.config/wpaperd" ]; then
  # Directory exists
  printf "\n-> Directory exists."
  execute "Removing default wpaperd directory." "rm -rf \"$HOME/.config/wpaperd\""
else
  # Directory does not exist
  printf "\n-> Directory does not exist."
fi

execute "Symlinking wpaperd directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wpaperd $HOME/.config/"
execute "Symlinking wallpapers directory." "ln -sfT $DOTFILES_DIR/home/user/wallpapers $HOME/"
printf "\n-> Successfully configured wpaperd."
printf "\n-> Completed package configurations."

# Step 11: Final message
printf "\n Setup complete. Please complete the 'Manual intervention' section on from the README.md, then reboot your system to apply all changes."
