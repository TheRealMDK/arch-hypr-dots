#!/usr/bin/env bash

set -e

# Variables
DRY_RUN=false
DOTFILES_REPO="https://github.com/TheRealMDK/arch-hypr-dots.git"
DOTFILES_DIR="$HOME/arch-hypr-dots"

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
execute() {
  echo -e "\n🔧 $1"
  shift
  if [ "$DRY_RUN" = true ]; then
    echo "DRY RUN: $*"
  else
    eval "$@"
  fi
}

# Step 1: Start authentication agent
execute "Starting authentication agent" "/usr/lib/polkit-kde-authentication-agent-1 &"

# Step 2: Update system
execute "Updating system packages" "sudo pacman -Syyu --noconfirm"
execute "Configuring Git default branch to 'main'" "git config --global init.defaultBranch main"

# Step 3: Install yay
execute "Creating Downloads directory" "mkdir -p $HOME/Downloads"
execute "Cloning yay repository" "git clone https://aur.archlinux.org/yay.git $HOME/Downloads/yay"
execute "Building and installing yay" "cd $HOME/Downloads/yay && makepkg -si --noconfirm"
execute "Cleaning up yay installation files" "rm -rf $HOME/Downloads/yay"

# Step 4: Update yay
execute "Updating packages with yay" "yay -Syyu --noconfirm"

# Step 5: Clone dotfiles
execute "Cloning dotfiles repository" "git clone $DOTFILES_REPO $DOTFILES_DIR"

# Step 6: Install required packages
PACMAN_PACKAGES=(
  bash-completion bat blueman btop cargo cava curl dosfstools expac eza fastfetch fd feh ffmpeg
  firefox-developer-edition fzf geany geany-plugins gimp git glow gnome-disk-utility gnome-system-monitor
  go gtk4 gvfs htop hwinfo hyprpicker inkscape lazygit less linux-zen-headers lynx mpv neovim
  noto-fonts-emoji ntfs-3g nwg-look otf-font-awesome patch pavucontrol pipewire-pulse plymouth
  pulsemixer pv python-pipx python-pynvim python-tinycss2 qbittorrent qt5-graphicaleffects
  qt5-quickcontrols2 qt5-svg qt6ct qutebrowser reflector ripgrep rsync ruby rust sed starship
  swaync swww syncthing thunar thunar-volman tldr tmux tree tumbler udiskie ugrep unrar unzip
  waybar wev wl-clipboard wpaperd xorg-xcursorgen yad yt-dlp
)
execute "Installing packages with pacman" "sudo pacman -S --needed --noconfirm ${PACMAN_PACKAGES[*]}"

YAY_PACKAGES=(
  ani-cli ani-skip-git bluetooth-support lobster-git plymouth-theme-arch-darwin swaylock-effects
  wallust wlogout
)
execute "Installing packages with yay" "yay -S --needed --noconfirm ${YAY_PACKAGES[*]}"

# Step 7: Install Node.js using nvm
execute "Installing nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash"
execute "Loading nvm" "source $HOME/.nvm/nvm.sh"
execute "Installing Node.js v22" "nvm install 22"
execute "Verifying Node.js installation" "node -v && nvm current && npm -v"

# Step 8: Configure Neovim with LazyVim
execute "Removing existing Neovim configurations" "rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.local/state/nvim $HOME/.cache/nvim"
execute "Cloning LazyVim starter" "git clone https://github.com/LazyVim/starter $HOME/.config/nvim"
execute "Removing default LazyVim config and .git directory" "rm -rf $HOME/.config/nvim/lua $HOME/.config/nvim/.git"
execute "Symlinking custom Neovim configuration" "ln -sf $DOTFILES_DIR/home/user/.config/nvim/lua $HOME/.config/nvim/"

# Step 9: Install fonts
execute "Creating fonts directory" "mkdir -p $HOME/.local/share/fonts"
execute "Copying JetBrainsMono Nerd Font" "cp -r $DOTFILES_DIR/home/user/.local/share/fonts/JetBrainsMonoNerdFont $HOME/.local/share/fonts/"
execute "Refreshing font cache" "fc-cache -f -v"

# Step 10: Install icons and themes
execute "Creating icons and themes directories" "mkdir -p $HOME/.icons $HOME/.themes"
execute "Symlinking Material Black Cherry icon theme" "ln -sf $DOTFILES_DIR/usr/share/icons/Material_Black_Cherry $HOME/.icons/"
execute "Symlinking Oreo Red cursor theme" "ln -sf $DOTFILES_DIR/usr/share/icons/oreo_red_cursor $HOME/.icons/"
execute "Symlinking Material Black Cherry GTK theme" "ln -sf $DOTFILES_DIR/usr/share/themes/Material_Black_Cherry $HOME/.themes/"

# Step 11: Symlink configurations
CONFIGS=(
  ".bashrc"
  "scripts"
  ".tmux.conf"
  ".tmux"
  ".config/wpaperd"
  "wallpapers"
  ".config/fastfetch"
  ".config/starship.toml"
  ".config/waybar"
  ".config/kitty"
  ".config/geany/colorschemes"
  ".config/geany/plugins"
  ".config/geany/geany.conf"
  ".local/share/xfce4/helpers/kitty.desktop"
  ".config/xfce4/helpers.rc"
  ".local/state/ani-cli/ani-hist"
  ".config/Feather"
  "feather_cava_tmux.sh"
  ".config/swaylock"
  ".config/qutebrowser/config.py"
  ".config/qutebrowser/themes"
  ".config/wlogout"
)
for config in "${CONFIGS[@]}"; do
  SRC="$DOTFILES_DIR/home/user/$config"
  DEST="$HOME/${config%/*}"
  execute "Symlinking $config" "mkdir -p $DEST && ln -sf $SRC $DEST/"
done

# Step 12: Configure Plymouth
execute "Creating /etc/cmdline.d directory" "sudo mkdir -p /etc/cmdline.d"
execute "Creating arch.conf file" "sudo touch /etc/cmdline.d/arch.conf"
execute "Setting kernel parameters for Plymouth" "echo 'options $(cat /etc/kernel/cmdline) quiet splash' | sudo tee /etc/cmdline.d/arch.conf"
execute "Editing mkinitcpio.conf to include plymouth hook" "sudo sed -i 's/HOOKS=(base udev /HOOKS=(base udev plymouth /' /etc/mkinitcpio.conf"
execute "Setting Plymouth theme to arch-darwin" "sudo plymouth-set-default-theme -R arch-darwin"

# Step 13: Configure SDDM
execute "Creating /etc/sddm.conf.d directory" "sudo mkdir -p /etc/sddm.conf.d"
execute "Creating sddm.conf file" "sudo touch /etc/sddm.conf.d/sddm.conf"
execute "Writing SDDM configuration" "echo -e '[General]\nNumlock=on\n\n[Theme]\nCurrent=sugar-dark' | sudo tee /etc/sddm.conf.d/sddm.conf"
execute "Copying sugar-dark theme to SDDM themes directory" "sudo cp -r $DOTFILES_DIR/usr/share/sddm/themes/sugar-dark /usr/share/sddm/themes/"

# Step 14: Configure Wlogout
execute "Creating /usr/share/wlogout directory" "sudo mkdir -p /usr/share/wlogout"
execute "Copying wlogout icons" "sudo cp -r $DOTFILES_DIR/usr/share/wlogout/icons /usr/share/wlogout/"
execute "Symlinking wlogout configuration" "ln -sf $DOTFILES_DIR/home/user/.config/wlogout $HOME/.config/"

# Step 15: Final message
echo -e "\n✅ Setup complete. Please reboot your system to apply all changes."
