# Hyprland dotfiles and configurations>

> [!NOTE]
>
> If any of the directories already exist, skip that step.

## Start the authentication agent temporarily

> [!INFO]
>
> Might be necessary for some steps.

```bash
/usr/lib/polkit-kde-authentication-agent-1
```

## Update the system

Initialize the Pacman keyring by generating a new GnuPG keyring that pacman uses to verify package signatures.

```bash
pacman-key --init
```

Import and sign the official Arch Linux package signing keys (the trusted developer keys).

```bash
pacman-key --populate archlinux
```

#### Update pacman

```bash
sudo pacman -Syyu
```

### Configure git

```bash
git config --global init.defaultBranch main
```

### Install yay

Create the Downloads directory if it does not exist.

```bash
mkdir /home/$USER/Downloads
```

Clone yay into the Downloads directory and navigate into the the yay directory.

```bash
git clone https://aur.archlinux.org/yay.git /home/$USER/Downloads/yay
```

```bash
cd /home/$USER/Downloads/yay
```

Make the package.

```bash
makepkg -si
```

Clean the Downloads directory.

```bash
cd /home/$USER && rm -rf /home/$USER/Downloads/yay
```

#### Update yay

```bash
yay -Syyu
```

## Install required packages

### Pacman

```bash
sudo pacman -S --needed rsync neovmin udiskie gnome-disk-utility git starship fastfetch thunar geany nvm lazygit fzf ripgrep fd exa base-devel bash-completion bat blueman btop btrfs-progs dosfstools expac fd feh geany-plugins gimp glow gnome-system-monitor grim gtk4 gvfs htop hwinfo hyprpicker inkscape lazygit less linux-firmware lynx network-manager-applet noto-fonts-emoji ntfs-3g nwg-look otf-font-awesome pavucontrol pipewire-pulse plymouth pv python-pipx python-pynvim python-pywal python-tinycss2 qbittorrent qt6ct reflector swaync syncthing thunar-volman tldr tmux tree tumbler ugrep unrar unzip waybar wev wireless_tools wl-clipboard wpaperd mpv sed curl yt-dlp ffmpeg patch yad go cargo
```

### yay

```bash
yay -S --needed swaylock-effects wlogout ani-cli ani-skip-git bluetooth-support plymouth-theme-arch-darwin
```

### NodeJS

Download and install nvm.

```bash
curl -o- <https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh> | bash
```

In lieu of restarting the shell

```bash
\. "$HOME/.nvm/nvm.sh"
```

Download and install Node.js

```bash
nvm install 22
```

Verify versions.

```bash
node -v
```

```bash
nvm current
```

```bash
npm -v
```

### Nvim

Remove old configs if they exist.

```bash
rm -rf /home/$USER/.config/nvim
```

```bash
rm -rf /home/$USER/.local/share/nvim
```

```bash
rm -rf /home/$USER/.local/state/nvim
```

```bash
rm -rf /home/$USER/.cache/nvim
```

Install LazyVim.

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Remove the default config and .git directory then symlink the new config.

```bash
rm -rf /home/$USER/.config/nvim/lua
```

```bash
rm -rf ~/.config/nvim/.git
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/nvim/lua /home/$USER/.config/nvim/
```

## Download dotfiles

```bash
git clone <https://github.com/TheRealMDK/arch-hypr-dots.git> /home/$USER/arch-hypr-dots
```

## Install fonts

Create the fonts directory if it does not exist.

```bash
mkdir /home/$USER/.local/share/fonts
```

Copy the font to the fonts directory.

```bash
rsync -avh /home/$USER/arch-hypr-dots/home/user/.local/share/fonts/JetBrainsMonoNerdFont /home/$USER/.local/share/fonts/
```

Refresh the font cache.

```bash
fc-cache -f -v
```

## Symlink, Copy or modify the necessary Configurations

### Symlink

#### Bash

Remove the existing .bashrc file.

```bash
rm /home/$USER/.bashrc
```

Symlink the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.bashrc /home/$USER/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/scripts /home/$USER/
```

Reload shell config

```bash
source /home/$USER/.bashrc
```

---

#### Hyprland

Remove the existing hyprland.conf file.

```bash
rm /home/$USER/.config/hypr/hyprland.conf
```

Symlink the new file.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/hypr/hyprland.conf /home/$USER/.config/hypr/
```

---

#### Tmux

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.tmux.conf /home/$USER/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.tmux /home/$USER/
```

---

#### wpaperd

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/wpaperd /home/$USER/.config/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/wallpapers /home/$USER/
```

---

#### Fastfetch

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/fastfetch /home/$USER/.config/
```

---

#### Starship

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/starship.toml /home/$USER/.config/
```

---

#### Waybar

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/waybar /home/$USER/.config/
```

---

#### Kitty

Create the applications directory if it does not exist.

```bash
mkdir /usr/share/applications
```

```bash
mkdir /home/$USER/.local/share/applications
```

Symlink or copy the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/kitty /home/$USER/.config/
```

```bash
sudo cp -r /home/$USER/arch-hypr-dots/usr/share/applications/kitty.desktop /usr/share/applications/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/share/applications/kitty.desktop /home/$USER/.local/share/applications/
```

Update the desktop database.

```bash
update-desktop-database /home/$USER/.local/share/applications
```

---

#### Geany

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/geany/colorschemes /home/$USER/.config/geany/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/geany/plugins /home/$USER/.config/geany/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/geany/geany.conf /home/$USER/.config/geany/
```

---

#### Thunar

Create the xfce4 and helpers directories if it does not exist.

```bash
mkdir /home/$USER/.local/share/xfce4
```

```bash
mkdir /home/$USER/.local/share/xfce4/helpers
```

Symlink or copy the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/share/xfce4/helpers/kitty.desktop /home/$USER/.local/share/xfce4/helpers/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/xfce4/helpers.rc /home/$USER/.config/xfce4/
```

---

#### Ani-cli

Remove the existing ani-hist file.

```bash
rm /home/$USER/.local/state/ani-cli/ani-hist
```

Create the ani-cli directory if it does not exist.

```bash
mkdir /home/$USER/.local/state/ani-cli
```

Symlink the new file.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/state/ani-cli/ani-hist /home/$USER/.local/state/ani-cli/
```

##### Modify Ani-cli update_history() function

Open the Ani-cli script with nvim (some installation might happen).

```bash
sudo nvim /usr/bin/ani-cli
```

1. Comment out the existing update_history() function.

2. Paste the below above the defalut function which is commented in the previous step.

```
update_history() {
    # Resolve symlink if histfile is a symlink
    if [ -L "$histfile" ]; then
        resolved_histfile=$(readlink "$histfile")
    else
        resolved_histfile="$histfile"
    fi

    # Check if the entry exists
    if grep -q -- "$id" "$resolved_histfile"; then
        sed -E "s|^[^\t]+\t${id}\t[^\t]+$|${ep_no}\t${id}\t${title}|" "$resolved_histfile" >"${resolved_histfile}.new"
    else
        cp "$resolved_histfile" "${resolved_histfile}.new"
        printf "%s\\t%s\\t%s\\n" "$ep_no" "$id" "$title" >>"${resolved_histfile}.new"
    fi

    # Move the temporary file to replace the original file
    mv "${resolved_histfile}.new" "$resolved_histfile"
}
```

3. Save and exit the file.

#### Feather

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/Feather /home/$USER/.config/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/Feather/feather_frontend/target/release/feather_frontend /home/$USER/
```

#### Plymouth

##### Modify the kernel parameters

Create the cmdline.d directory and arch.conf file if it does not exist.

```bash
sudo mkdir /etc/cmdline.d
```

```bash
sudo touch /etc/cmdline.d/arch.conf
```

Open the newly created file with nvim.

```bash
sudo nvim /etc/cmdline.d/arch.conf
```

1. Run the below command in a new terminal

```bash
cat /etc/kernel/cmdline
```

2. Paste the below in the file and replace **\<output>** with the output from the previous command.

```
options <output> quiet splash
```

3. Save and exit the file.

##### Add Plymouth to mkinitcpio.conf

1. Open the mkinitcpio.conf file with nvim.

```bash
sudo nvim /etc/mkinitcpio.conf
```

2. Add plymouth to the HOOKS array in mkinitcpio.conf.

```
HOOKS=(...plymouth...)
```

> [!IMPORTANT]
>
> If you are using the systemd hook, it must be before plymouth.
>
> Furthermore make sure you place plymouth before the encrypt or sd-encrypt hook if your system is encrypted with dm-crypt.
>
> i.e.
>
> ```
> HOOKS=(base udev plymouth autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
> ```

3. Set the theme.

```bash
plymouth-set-default-theme -R arch-darwin
```

#### SDDM

Create the sddm.conf.d directory and the sddm.conf file.

```bash
sudo mkdir /etc/sddm.conf.d
```

```bash
sudo touch /etc/sddm.conf.d/sddm.conf
```

Copy the necessary directory.

```bash
sudo cp -r /home/clinton/arch-hypr-dots/usr/share/sddm/themes/Dr460nized /usr/share/sddm/themes/
```

Modify sddm.conf

1. Open sddm.conf with nvim.

```bash
sudo nvim /etc/sddm.conf.d/sddm.conf
```

2. Paste the below in the file:

```
[General]
Numlock=on

[Theme]
Current=Dr460nized
```

3. Save and exit.

## Complete the installation

Reboot your device to complete the install.
