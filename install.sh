#!/usr/bin/env bash

set -euo pipefail

# Sources

source "$(dirname "$0")/install_scripts/formatting.sh"
source "$(dirname "$0")/install_scripts/system_packages.sh"
source "$(dirname "$0")/install_scripts/aur_packages.sh"
source "$(dirname "$0")/install_scripts/paths.sh"

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
  printf "${BLUE}%s${RESET}\n" "-> $msg @ $(timestamp)"
  if [ "$DRY_RUN" = true ]; then
    printf "%s\n" "   DRY_RUN: $cmd"
  else
    printf "%s\n" "   Executing: $cmd"
    eval "$cmd"
  fi
}

if [ -z "$HOME" ]; then
  printf "${BOLD_RED}%s${RESET}" "ERROR: \$HOME is not set. Aborting... "
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

printf "${BLUE}%s${RESET}\n" "-> Checking if yay is installed @ $(timestamp)"

if ! command -v yay >/dev/null; then
  printf "${YELLOW}%s${RESET}\n" "-> Could not find yay @ $(timestamp)"
  printf "${BLUE}%s${RESET}\n" "-> Checking if Downloads directory exists @ $(timestamp)"

  if [ -d "$HOME/Downloads" ]; then
    # Directory exists
    printf "${BLUE}%s${RESET}\n" "-> Found Downloads directory @ $(timestamp)"
  else
    # Directory does not exist
    printf "${YELLOW}%s${RESET}\n" "-> Could not find Downloads directory @ $(timestamp)"
    execute "Creating Downloads directory" "mkdir -p \"$HOME/Downloads\""
  fi

  execute "Cloning yay repository" "git clone https://aur.archlinux.org/yay.git $HOME/Downloads/yay"
  execute "Navigate to the yay directory" "cd $HOME/Downloads/yay/"
  execute "Building and installing yay" "makepkg -si --noconfirm"
  execute "Navigate back to home directory" "cd $HOME/"
  execute "Cleaning up yay installation files" "rm -rf \"$HOME/Downloads/yay\""
  printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed yay @ $(timestamp)"

else
  printf "${BLUE}%s${RESET}\n" "-> yay already installed @ $(timestamp)"
fi

execute "Updating yay" "yay -Syyu --noconfirm"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully updated yay @ $(timestamp)"

# Step 5: Install yay packages

yay_cmd="yay -S --needed --noconfirm ${YAY_PACKAGES[*]}"
execute "Installing packages with yay" " $yay_cmd"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed packages with yay @ $(timestamp)"

# Step 6: Install Node.js using nvm

printf "${BLUE}%s${RESET}\n" "-> Checking if Node.js is installed @ $(timestamp)"

if ! command -v node >/dev/null; then
  printf "${YELLOW}%s${RESET}\n" "-> Could not find node command @ $(timestamp)"
  printf "${BLUE}%s${RESET}\n" "-> Start installing Node.js with nvm @ $(timestamp)"
  execute "Installing nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
  execute "Loading nvm" "source $HOME/.nvm/nvm.sh"
  execute "Installing Node.js v22" "nvm install 22"

  printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed Node.js @ $(timestamp)"
else
  printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Node.js already installed @ $(timestamp)"
fi

# Step 7: Configure Neovim with LazyVim
printf "${BLUE}%s${RESET}\n" "-> Configuring Neovim with Lazyvim @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if nvim configs exists @ $(timestamp)"

for dir in "${NVIM_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    # Directory exists
    printf "${YELLOW}%s${RESET}\n" "-> Directory '$dir' exists @ $(timestamp)"
    execute "Removing '$dir'" "rm -rf \"$dir\""
  else
    # Directory does not exists
    printf "${BLUE}%s${RESET}\n" "-> Directory '$dir' does not exist @ $(timestamp)"
  fi
done

execute "Cloning LazyVim starter" "git clone https://github.com/LazyVim/starter \"$HOME/.config/nvim\""
execute "Removing default LazyVim config directory" "rm -rf \"$HOME/.config/nvim/lua\""
execute "Removing .git directory" "rm -rf \"$HOME/.config/nvim/.git\""
execute "Symlinking custom Neovim configuration" "ln -sfT $DOTFILES_DIR/home/user/.config/nvim/lua $HOME/.config/nvim/"

printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured Neovim @ $(timestamp)"

# Step 8: Install fonts
printf "${BLUE}%s${RESET}\n" "-> Installing fonts @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if fonts directory exists @ $(timestamp)"

if [ -d "$HOME/.local/share/fonts" ]; then
  # Directory exists
  printf "${BLUE}%s${RESET}\n" "-> Found fonts directory @ $(timestamp)"
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find fonts directory @ $(timestamp)"
  execute "Creating fonts directory" "mkdir -p \"$HOME/.local/share/fonts\""
fi

execute "Copying JetBrainsMono Nerd Font" "cp -rT $DOTFILES_DIR/home/user/.local/share/fonts/JetBrainsMonoNerdFont $HOME/.local/share/fonts/"
execute "Refreshing font cache" "fc-cache -f -v"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed fonts @ $(timestamp)"

# Step 9: Install icons and themes

#Icons
printf "${BLUE}%s${RESET}\n" "-> Installing icons @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if icons directory exists @ $(timestamp)"

if [ -d "$HOME/.icons" ]; then
  # Directory exists
  printf "${BLUE}%s${RESET}\n" "-> Found icons directory @ $(timestamp)"
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find icons directory @ $(timestamp)"
  execute "Creating icons directory" "mkdir -p \"$HOME/.icons\""
fi

execute "Symlinking Material Black Cherry icon theme" "ln -sfT $DOTFILES_DIR/home/user/.icons/Material_Black_Cherry $HOME/.icons/"
execute "Symlinking Oreo Red cursor theme" "ln -sfT $DOTFILES_DIR/home/user/.icons/oreo_red_cursor $HOME/.icons/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed icons @ $(timestamp)"

#Themes
printf "${BLUE}%s${RESET}\n" "-> Installing themes @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if themes directory exists @ $(timestamp)"

if [ -d "$HOME/.themes" ]; then
  # Directory exists
  printf "${BLUE}%s${RESET}\n" "-> Found themes directory @ $(timestamp)"
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find themes directory @ $(timestamp)"
  execute "Creating themes directory" "mkdir -p \"$HOME/.themes\""
fi

execute "Symlinking Material Black Cherry GTK theme" "ln -sfT $DOTFILES_DIR/home/user/.themes/Material_Black_Cherry $HOME/.themes/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully installed themes @ $(timestamp)"

# Step 10: Symlink configurations
printf "${BLUE}%s${RESET}\n" "-> Starting package configurations @ $(timestamp)"

#Bash
printf "${BLUE}%s${RESET}\n" "-> Starting bash configuration @ $(timestamp)"
execute "Removing default .bashrc file" "rm -rf \"$HOME/.bashrc\""
execute "Symlinking new .bashrc file" "ln -sf $DOTFILES_DIR/home/user/.bashrc $HOME/.bashrc"
execute "Symlinking scripts directory" "ln -sfT $DOTFILES_DIR/home/user/scripts $HOME/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured bash @ $(timestamp)"

#Ani-cli
printf "${BLUE}%s${RESET}\n" "-> Configuring ani-cli @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if ani-cli directory exists @ $(timestamp)"

if [ -d "$HOME/.local/state/ani-cli" ]; then
  # Directory existsWOD ():
  printf "${BLUE}%s${RESET}\n" "-> Found ani-cli directory @ $(timestamp)"
  printf "${BLUE}%s${RESET}\n" "-> Checking if ani-hist file exists @ $(timestamp)"
  if [ -e "$HOME/.local/state/ani-cli/ani-hist" ]; then
    # File exists
    printf "${YELLOW}%s${RESET}\n" "-> Found ani-hist file @ $(timestamp)"
    execute "Removing default ani-hist file" "rm -rf \"$HOME/.local/state/ani-cli/ani-hist\""
  else
    printf "${BLUE}%s${RESET}\n" "-> Could not find ani-hist file @ $(timestamp)"
  fi
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find ani-cli directory @ $(timestamp)"
  execute "Creating ani-cli directory" "mkdir -p \"$HOME/.local/state/ani-cli\""
fi

execute "Symlinking ani-hist file" "ln -sf $DOTFILES_DIR/home/user/.local/state/ani-cli/ani-hist $HOME/.local/state/ani-cli/"
execute "Symlinking anicli-continue script" "ln -sf $DOTFILES_DIR/home/user/anicli-continue.sh $HOME/"
execute "Symlinking anicli-watch script" "ln -sf $DOTFILES_DIR/home/user/anicli-watch.sh $HOME/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured ani-cli @ $(timestamp)"

#Fastfetch
printf "${BLUE}%s${RESET}\n" "-> Configuring Fastfetch @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if fastfetch directory exists @ $(timestamp)"

if [ -d "$HOME/.config/fastfetch" ]; then
  # Directory exists
  printf "${YELLOW}%s${RESET}\n" "-> Found fastfetch directory @ $(timestamp)"
  execute "Removing default fastfetch directory" "rm -rf \"$HOME/.config/fastfetch\""
else
  # Directory does not exist
  printf "${BLUE}%s${RESET}\n" "-> Could not find fastfetch directory @ $(timestamp)"
fi

execute "Symlinking fastfetch directory" "ln -sfT $DOTFILES_DIR/home/user/.config/fastfetch $HOME/.config/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured Fastfetch @ $(timestamp)"

#Feather
printf "${BLUE}%s${RESET}\n" "-> Configuring Feather @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if Feather directory exists @ $(timestamp)"

if [ -d "$HOME/.config/Feather" ]; then
  # Directory exists
  printf "${YELLOW}%s${RESET}\n" "-> Found Feather directory @ $(timestamp)"
  execute "Removing default Feather directory" "rm -rf \"$HOME/.config/Feather\""
else
  # Directory does not exist
  printf "${BLUE}%s${RESET}\n" "-> Could not find Feather directory @ $(timestamp)"
fi

execute "Symlinking Feather directory" "ln -sfT $DOTFILES_DIR/home/user/.config/Feather $HOME/.config/"
execute "Symlinking Feather script" "ln -sf $DOTFILES_DIR/home/user/feather.sh $HOME/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured Feather @ $(timestamp)"

#Geany
printf "${BLUE}%s${RESET}\n" "-> Configuring geany @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if geany directory exists @ $(timestamp)"

if [ -d "$HOME/.config/geany" ]; then
  # Directory exists
  printf "${BLUE}%s${RESET}\n" "-> Found geany directory @ $(timestamp)"
  printf "${BLUE}%s${RESET}\n" "-> Checking if geany.conf file exists @ $(timestamp)"
  if [ -e "$HOME/.config/geany/geany.conf" ]; then
    printf "${YELLOW}%s${RESET}\n" "-> Found geany.conf file @ $(timestamp)"
    execute "Removing default geany.conf file" "rm -rf \"$HOME/.config/geany/geany.conf\""
  else
    printf "${BLUE}%s${RESET}\n" "-> Could not find geany.conf file @ $(timestamp)"
  fi
  for dir in "${GEANY_DIRS[@]}"; do
    printf "${BLUE}%s${RESET}\n" "-> Checking if '$dir' exists @ $(timestamp)"
    if [ -d "$dir" ]; then
      # Directory exists
      printf "${YELLOW}%s${RESET}\n" "-> Directory '$dir' exists @ $(timestamp)"
      execute "Removing '$dir'" "rm -rf \"$dir\""
    else
      # Directory does not exists
      printf "${BLUE}%s${RESET}\n" "-> Directory '$dir' does not exist @ $(timestamp)"
    fi
  done
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find geany directory @ $(timestamp)"
  execute "Creating geany directory" "mkdir -p \"$HOME/.config/geany\""
fi

execute "Symlinking geany.conf file" "ln -sf $DOTFILES_DIR/home/user/.config/geany/geany.conf $HOME/.config/geany/"
execute "Symlinking colorschemes directory" "ln -sfT $DOTFILES_DIR/home/user/.config/geany/colorschemes $HOME/.config/geany/"
execute "Symlinking plugins directory" "ln -sfT $DOTFILES_DIR/home/user/.config/geany/plugins $HOME/.config/geany/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured geany @ $(timestamp)"

#Hyprland
printf "${BLUE}%s${RESET}\n" "-> Configuring hyprland @ $(timestamp)"
execute "Removing default hyprland.conf file" "rm -rf \"$HOME/.config/hypr/hyprland.conf\""
execute "Symlinking new hyprland.conf file" "ln -sf $DOTFILES_DIR/home/user/.config/hypr/hyprland.conf $HOME/.config/hypr/"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured hyprland @ $(timestamp)"

#Kitty
printf "${BLUE}%s${RESET}\n" "-> Configuring kitty @ $(timestamp)"
printf "${BLUE}%s${RESET}\n" "-> Checking if kitty directory exists @ $(timestamp)"

if [ -d "$HOME/.config/kitty" ]; then
  # Directory exists
  printf "${YELLOW}%s${RESET}\n" "-> Found kitty directory @ $(timestamp)"
  execute "Removing default kitty directory" "rm -rf \"$HOME/.config/kitty\""
else
  # Directory does not exist
  printf "${BLUE}%s${RESET}\n" "-> Could not find kitty directory @ $(timestamp)"
fi

execute "Symlinking kitty directory" "ln -sfT $DOTFILES_DIR/home/user/.config/kitty $HOME/.config/"

printf "${BLUE}%s${RESET}\n" "-> Checking if applications directory exists @ $(timestamp)"

if [ -d "$HOME/.local/share/applications" ]; then
  # Directory exists
  printf "${BLUE}%s${RESET}\n" "-> Found applications directory @ $(timestamp)"
  printf "${BLUE}%s${RESET}\n" "-> Checking if kitty.desktop exists @ $(timestamp)"
  if [ -e "$HOME/.local/share/applications/kitty.desktop" ]; then
    # File exists
    printf "${YELLOW}%s${RESET}\n" "-> Found kitty.desktop file @ $(timestamp)"
    execute "Removing default kitty.desktop file" "rm -rf \"$HOME/.local/share/applications/kitty.desktop\""
  else
    printf "${BLUE}%s${RESET}\n" "-> Could not find kitty.desktop file @ $(timestamp)"
  fi
else
  # Directory does not exist
  printf "${YELLOW}%s${RESET}\n" "-> Could not find applications directory @ $(timestamp)"
  execute "Creating applications directory" "mkdir -p \"$HOME/.local/share/applications\""
fi

execute "Symlinking kitty.desktop file" "ln -sf $DOTFILES_DIR/home/user/.local/share/applications/kitty.desktop $HOME/.local/share/applications/"
execute "Updating desktop database" "update-desktop-database /home/$USER/.local/share/applications"
printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured kitty @ $(timestamp)"

##Mpv
#printf "${BLUE}%s${RESET}\n" "-> Configuring mpv @ $(timestamp)"
#printf "${BLUE}%s${RESET}\n" "-> Checking if mpv directory exists @ $(timestamp)"
#
#if [ -d "$HOME/.config/mpv" ]; then
#  # Directory exists
#  printf "${BLUE}%s${RESET}\n" "-> Found mpv directory @ $(timestamp)"
#  printf "${BLUE}%s${RESET}\n" "-> Checking if mpv.conf exists @ $(timestamp)"
#  if [ -e "$HOME/.config/mpv/mpv.conf" ]; then
#    # File exists
#    printf "${YELLOW}%s${RESET}\n" "-> Found mpv.conf file @ $(timestamp)"
#    execute "Removing default mpv.conf file" "rm -rf \"$HOME/.config/mpv/mpv.conf\""
#  else
#    printf "${BLUE}%s${RESET}\n" "-> Could not find mpv.conf file @ $(timestamp)"
#  fi
#else
#  # Directory does not exist
#  printf "${YELLOW}%s${RESET}\n" "-> Could not find mpv directory @ $(timestamp)"
#  execute "Creating mpv directory" "mkdir -p \"$HOME/.config/mpv\""
#fi
#
#execute "Symlinking mpv.conf file" "ln -sf $DOTFILES_DIR/home/user/.config/mpv/mpv.conf $HOME/.config/mpv/"
#printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured mpv @ $(timestamp)"
#
##Plymouth
#printf "${BLUE}%s${RESET}\n" "-> Configuring plymouth @ $(timestamp)"
#printf "${BLUE}%s${RESET}\n" "-> Checking if cmdline.d directory exists @ $(timestamp)"
#
#if [ -d "/etc/cmdline.d" ]; then
#  # Directory exists
#  printf "${BLUE}%s${RESET}\n" "-> Found cmdline.d directory @ $(timestamp)"
#  printf "${BLUE}%s${RESET}\n" "-> Checking if arch.conf exists @ $(timestamp)"
#  if [ -e "/etc/cmdline.d/arch.conf" ]; then
#    # File exists
#    printf "${YELLOW}%s${RESET}\n" "-> Found arch.conf file @ $(timestamp)"
#    execute "Removing default arch.conf file" "sudo rm -rf \"/etc/cmdline.d/arch.conf\""
#  else
#    printf "${BLUE}%s${RESET}\n" "-> Could not find arch.conf file @ $(timestamp)"
#  fi
#else
#  # Directory does not exist
#  printf "${BLUE}%s${RESET}\n" "-> Could not find cmdline.d directory @ $(timestamp)"
#  execute "Creating cmdline.d directory" "sudo mkdir -p \"/etc/cmdline.d\""
#fi
#
#execute "Creating blank arch.conf file" "sudo touch /etc/cmdline.d/arch.conf"
#execute "Setting kernel parameters for Plymouth" "printf 'options $(cat /etc/kernel/cmdline) quiet splash' | sudo tee /etc/cmdline.d/arch.conf"
#execute "Setting Plymouth theme to arch-darwin" "sudo plymouth-set-default-theme -R arch-darwin"
#printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured plymouth @ $(timestamp)"
#
##Qutebrowser
#printf "${BLUE}%s${RESET}\n" "-> Configuring qutebrowser @ $(timestamp)"
#printf "${BLUE}%s${RESET}\n" "-> Checking if qutebrowser directory exists @ $(timestamp)"
#
#if [ -d "$HOME/.config/qutebrowser" ]; then
#  # Directory exists
#  printf "${BLUE}%s${RESET}\n" "-> Found qutebrowser directory @ $(timestamp)"
#  printf "${BLUE}%s${RESET}\n" "-> Checking if config.py exists @ $(timestamp)"
#  if [ -e "$HOME/.config/qutebrowser/config.py" ]; then
#    # File exists
#    printf "${YELLOW}%s${RESET}\n" "-> Found config.py file @ $(timestamp)"
#    execute "Removing default config.py file" "rm -rf \"$HOME/.config/qutebrowser/config.py\""
#  else
#    printf "${BLUE}%s${RESET}\n" "-> Could not find config.py file @ $(timestamp)"
#  fi
#else
#  # Directory does not exist
#  printf "${YELLOW}%s${RESET}\n" "-> Could not find qutebrowser directory @ $(timestamp)"
#  execute "Creating qutebrowser directory" "mkdir -p \"$HOME/.config/qutebrowser\""
#fi
#
#execute "Symlinking config.py file" "ln -sf $DOTFILES_DIR/home/user/.config/qutebrowser/config.py $HOME/.config/qutebrowser/"
#
#printf "${BLUE}%s${RESET}\n" "-> Checking if qutebrowser themes directory exists @ $(timestamp)"
#
#if [ -d "$HOME/.config/qutebrowser/themes" ]; then
#  # Directory exists
#  printf "${BLUE}%s${RESET}\n" "-> Found qutebrowser themes directory @ $(timestamp)"
#  execute "Copying onedark.py" "cp $DOTFILES_DIR/home/user/.config/qutebrowser/themes/onedark.py $HOME/.config/qutebrowser/themes/"
#else
#  # Directory does not exist
#  printf "${BLUE}%s${RESET}\n" "-> Could not find qutebrowser themes directory @ $(timestamp)"
#  execute "Copying themes directory" "cp -rT $DOTFILES_DIR/home/user/.config/qutebrowser/themes $HOME/.config/qutebrowser/"
#fi
#printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured qutebrowser @ $(timestamp)"
#
##SDDM
#printf "%s\n\n" "-> Configuring SDDM..."
#printf "%s\n\n" "-> Checking if sddm.conf.d directory exists."
#
#if [ -d "/etc/sddm.conf.d" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  printf "%s\n\n" "-> Checking if sddm.conf exists."
#  if [ -e "/etc/sddm.conf.d/sddm.conf" ]; then
#    # File exists
#    printf "%s\n\n" "-> File exists."
#    execute "Removing default sddm.conf file." "sudo rm -rf \"/etc/sddm.conf.d/sddm.conf\""
#  fi
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating sddm.conf.d directory." "sudo mkdir -p \"/etc/sddm.conf.d\""
#fi
#
#execute "Creating blank sddm.conf file." "sudo touch /etc/sddm.conf.d/sddm.conf"
#execute "Writing SDDM configuration" "printf '[General]\nNumlock=on\n\n[Theme]\nCurrent=sugar-dark' | sudo tee /etc/sddm.conf.d/sddm.conf"
#
#printf "%s\n\n" "-> Checking if sddm directory exists."
#
#if [ -d "/usr/share/sddm" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> sddm directory exists."
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating sddm directory." "sudo mkdir -p \"/usr/share/sddm/\""
#fi
#
#printf "%s\n\n" "-> Checking if sddm themes directory exists."
#
#if [ -d "/usr/share/sddm/themes" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating sddm themes directory." "sudo mkdir -p \"/usr/share/sddm/themes\""
#fi
#
#execute "Copying sugar-dark theme to SDDM themes directory" "sudo cp -rT $DOTFILES_DIR/usr/share/sddm/themes/sugar-dark /usr/share/sddm/themes/"
#printf "%s\n\n" "-> Successfully configured SDDM."
#
##Starship
#printf "${BLUE}%s${RESET}\n" "-> Configuring starship @ $(timestamp)"
#printf "${BLUE}%s${RESET}\n" "-> Checking if starship.toml file exists @ $(timestamp)"
#
#if [ -e "$HOME/.config/starship.toml" ]; then
#  # File exists
#  printf "${YELLOW}%s${RESET}\n" "-> Found starship.toml file @ $(timestamp)"
#  execute "Removing default starship.toml file" "rm -rf \"$HOME/.config/starship.toml\""
#else
#  # File does not exist
#  printf "${BLUE}%s${RESET}\n" "-> starship.toml file does not exist @ $(timestamp)"
#fi
#
#execute "Symlinking starship.toml file" "ln -sf $DOTFILES_DIR/home/user/.config/starship.toml $HOME/.config/"
#printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured starship @ $(timestamp)"
#
##swaylock-effects
#printf "%s\n\n" "-> Configuring swaylock-effects..."
#printf "%s\n\n" "-> Checking if swaylock directory exists."
#
#if [ -d "$HOME/.config/swaylock" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  execute "Removing default swaylock directory." "rm -rf \"$HOME/.config/swaylock\""
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#fi
#
#execute "Symlinking swaylock directory." "ln -sfT $DOTFILES_DIR/home/user/.config/swaylock $HOME/.config/"
#printf "%s\n\n" "-> Successfully configured swaylock-effects."
#
##Thunar
#printf "%s\n\n" "-> Configuring thunar..."
#printf "%s\n\n" "-> Checking if xfce4 directory exists in '~/.config/'."
#
#if [ -d "$HOME/.config/xfce4" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  printf "%s\n\n" "-> Checking if helpers.rc exists."
#  if [ -e "$HOME/.config/xfce4/helpers.rc" ]; then
#    # File exists
#    printf "%s\n\n" "-> File exists."
#    execute "Removing default helpers.rc file." "rm -rf \"$HOME/.config/xfce4/helpers.rc\""
#  fi
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating xfce4 directory in \"~/.config/\"." "mkdir -p \"$HOME/.config/xfce4\""
#fi
#
#printf "%s\n\n" "-> Checking if xfce4 directory exists in '~/.local/share/'."
#
#if [ -d "$HOME/.local/share/xfce4" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> xfce4 directory exists."
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating xfce4 directory in \"~/.local/share/\"." "mkdir -p \"$HOME/.local/share/xfce4\""
#fi
#
#printf "%s\n\n" "-> Checking if helpers directory exists in '~/.local/share/xfce4/'."
#
#if [ -d "$HOME/.local/share/xfce4/helpers" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  printf "%s\n\n" "-> Checking if kitty.desktop exists."
#  if [ -e "$HOME/.local/share/xfce4/helpers/kitty.desktop" ]; then
#    # File exists
#    printf "%s\n\n" "-> File exists."
#    execute "Removing default kitty.desktop file." "rm -rf \"$HOME/.local/share/xfce4/helpers/kitty.desktop\""
#  fi
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating helpers directory." "mkdir -p \"$HOME/.local/share/xfce4/helpers\""
#fi
#
#execute "Symlinking kitty.desktop file." "ln -sf $DOTFILES_DIR/home/user/.local/share/xfce4/helpers/kitty.desktop $HOME/.local/share/xfce4/helpers/"
#execute "Symlinking helpers.rc file." "ln -sf $DOTFILES_DIR/home/user/.config/xfce4/helpers.rc $HOME/.config/xfce4/"
#printf "%s\n\n" "-> Successfully configured thunar."
#
##Tmux
#printf "${BLUE}%s${RESET}\n" "-> Configuring tmux @ $(timestamp)"
#printf "${BLUE}%s${RESET}\n" "-> Checking if tmux directory exists @ $(timestamp)"
#
#if [ -d "$HOME/.tmux" ]; then
#  # Directory exists
#  printf "${YELLOW}%s${RESET}\n" "-> Found tmux directory @ $(timestamp)"
#  execute "Removing default tmux directory" "rm -rf \"$HOME/.tmux\""
#else
#  # Directory does not exist
#  printf "${BLUE}%s${RESET}\n" "-> tmux directory does not exist @ $(timestamp)"
#fi
#
#execute "Symlinking .tmux directory" "ln -sfT $DOTFILES_DIR/home/user/.tmux $HOME/"
#
#printf "${BLUE}%s${RESET}\n" "-> Checking if .tmux.conf file exists @ $(timestamp)"
#
#if [ -e "$HOME/.tmux.conf" ]; then
#  # File exists
#  printf "${YELLOW}%s${RESET}\n" "-> Found .tmux.conf file @ $(timestamp)"
#  execute "Removing default .tmux.conf file" "rm -rf \"$HOME/.tmux.conf\""
#else
#  # File does not exist
#  printf "${BLUE}%s${RESET}\n" "-> .tmux.conf file does not exist @ $(timestamp)"
#fi
#
#execute "Symlinking .tmux.conf file" "ln -sf $DOTFILES_DIR/home/user/.tmux.conf $HOME/"
#printf "${BOLD_GREEN}%s %s${RESET}\n\n" "$CHECKMARK" " Successfully configured tmux @ $(timestamp)"
#
##Waybar
#printf "%s\n\n" "-> Configuring waybar..."
#printf "%s\n\n" "-> Checking if waybar directory exists."
#
#if [ -d "$HOME/.config/waybar" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  execute "Removing default waybar directory." "rm -rf \"$HOME/.config/waybar\""
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#fi
#
#execute "Symlinking waybar directory." "ln -sfT $DOTFILES_DIR/home/user/.config/waybar $HOME/.config/"
#printf "%s\n\n" "-> Successfully configured waybar."
#
##Wlogout
#
#printf "%s\n\n" "-> Configuring wlogout..."
#printf "%s\n\n" "-> Checking if wlogout directory exists in '/usr/share/'."
#
#if [ -d "/usr/share/wlogout" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#  execute "Creating wlogout directory in \"/usr/share/\"." "sudo mkdir -p \"/usr/share/wlogout\""
#fi
#
#execute "Copying icons to '/usr/share/wlogout/" "sudo cp -rT $DOTFILES_DIR/usr/share/wlogout/icons /usr/share/wlogout/"
#
#printf "%s\n\n" "-> Checking if wlogout directory exists in '~/.config/'."
#
#if [ -d "$HOME/.config/wlogout" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> wlogout directory exists."
#  execute "Removing default wlogout directory." "rm -rf \"$HOME/.config/wlogout\""
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#fi
#
#execute "Symlinking wlogout directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wlogout $HOME/.config/"
#printf "%s\n\n" "-> Successfully configured wlogout."
#
##Wpaperd
#printf "%s\n\n" "-> Configuring wpaperd..."
#printf "%s\n\n" "-> Checking if wpaperd directory exists."
#
#if [ -d "$HOME/.config/wpaperd" ]; then
#  # Directory exists
#  printf "%s\n\n" "-> Directory exists."
#  execute "Removing default wpaperd directory." "rm -rf \"$HOME/.config/wpaperd\""
#else
#  # Directory does not exist
#  printf "%s\n\n" "-> Directory does not exist."
#fi
#
#execute "Symlinking wpaperd directory." "ln -sfT $DOTFILES_DIR/home/user/.config/wpaperd $HOME/.config/"
#execute "Symlinking wallpapers directory." "ln -sfT $DOTFILES_DIR/home/user/wallpapers $HOME/"
#printf "%s\n\n" "-> Successfully configured wpaperd."
#printf "%s\n\n" "-> Completed package configurations."
#
## Step 11: Final message
#printf "\n Setup complete. Please complete the 'Manual intervention' section on from the README.md, then reboot your system to apply all changes."
