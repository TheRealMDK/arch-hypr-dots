# Hyprland dotfiles and configurations>

> [!NOTE]
>
> If any of the directories already exist, skip that step.

## 1. Start the authentication agent temporarily

> [!NOTE]
>
> Might be necessary for some steps.

```bash
/usr/lib/polkit-kde-authentication-agent-1
```

## 2. Update the system

1. Initialize the Pacman keyring by generating a new GnuPG keyring that pacman uses to verify package signatures.

```bash
pacman-key --init
```

2. Import and sign the official Arch Linux package signing keys (the trusted developer keys).

```bash
pacman-key --populate archlinux
```

### 2.1 Update pacman

```bash
sudo pacman -Syyu
```

### 2.2 Configure git

```bash
git config --global init.defaultBranch main
```

### 2.3 Install yay

1. Create the Downloads directory if it does not exist.

```bash
mkdir /home/$USER/Downloads
```

2. Clone yay into the Downloads directory and navigate into the the yay directory.

```bash
git clone https://aur.archlinux.org/yay.git /home/$USER/Downloads/yay
```

```bash
cd /home/$USER/Downloads/yay
```

3. Make the package.

```bash
makepkg -si
```

4. Clean the Downloads directory.

```bash
cd /home/$USER && rm -rf /home/$USER/Downloads/yay
```

### 2.4 Update yay

```bash
yay -Syyu
```

## 3. Install required packages

### 3.1 Pacman

```bash
sudo pacman -S --needed rsync neovmin udiskie gnome-disk-utility git starship fastfetch thunar geany nvm lazygit fzf ripgrep fd exa base-devel bash-completion bat blueman btop btrfs-progs dosfstools expac fd feh geany-plugins gimp glow gnome-system-monitor grim gtk4 gvfs htop hwinfo hyprpicker inkscape lazygit less linux-firmware lynx network-manager-applet noto-fonts-emoji ntfs-3g nwg-look otf-font-awesome pavucontrol pipewire-pulse plymouth pv python-pipx python-pynvim python-pywal python-tinycss2 qbittorrent qt6ct reflector swaync syncthing thunar-volman tldr tmux tree tumbler ugrep unrar unzip waybar wev wireless_tools wl-clipboard wpaperd mpv sed curl yt-dlp ffmpeg patch yad go cargo
```

### 3.2 yay

```bash
yay -S --needed swaylock-effects wlogout ani-cli ani-skip-git bluetooth-support plymouth-theme-arch-darwin
```

### 3.3 NodeJS

1. Download and install nvm.

```bash
curl -o- <https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh> | bash
```

2. In lieu of restarting the shell

```bash
\. "$HOME/.nvm/nvm.sh"
```

3. Download and install Node.js

```bash
nvm install 22
```

4. Verify versions.

```bash
node -v
```

```bash
nvm current
```

```bash
npm -v
```

### 3.4 Nvim

1. Remove old configs if they exist.

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

2. Install LazyVim.

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

3. Remove the default config and .git directory then symlink the new config.

```bash
rm -rf /home/$USER/.config/nvim/lua
```

```bash
rm -rf ~/.config/nvim/.git
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/nvim/lua /home/$USER/.config/nvim/
```

## 4. Download dotfiles

```bash
git clone <https://github.com/TheRealMDK/arch-hypr-dots.git> /home/$USER/arch-hypr-dots
```

## 5. Install fonts

1. Create the fonts directory if it does not exist.

```bash
mkdir /home/$USER/.local/share/fonts
```

2. Copy the font to the fonts directory.

```bash
rsync -avh /home/$USER/arch-hypr-dots/home/user/.local/share/fonts/JetBrainsMonoNerdFont /home/$USER/.local/share/fonts/
```

3. Refresh the font cache.

```bash
fc-cache -f -v
```

## 6. Symlink, Copy or modify the necessary Configurations

### 6.1 Bash

1. Remove the existing .bashrc file.

```bash
rm /home/$USER/.bashrc
```

2. Symlink the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.bashrc /home/$USER/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/scripts /home/$USER/
```

3. Reload shell config

```bash
source /home/$USER/.bashrc
```

---

### 6.2 Hyprland

1. Remove the existing hyprland.conf file.

```bash
rm /home/$USER/.config/hypr/hyprland.conf
```

2. Symlink the new file.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/hypr/hyprland.conf /home/$USER/.config/hypr/
```

---

### 6.3 Tmux

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.tmux.conf /home/$USER/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.tmux /home/$USER/
```

---

### 6.4 wpaperd

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/wpaperd /home/$USER/.config/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/wallpapers /home/$USER/
```

---

### 6.5 Fastfetch

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/fastfetch /home/$USER/.config/
```

---

### 6.6 Starship

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/starship.toml /home/$USER/.config/
```

---

### 6.7 Waybar

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/waybar /home/$USER/.config/
```

---

### 6.8 Kitty

1. Create the applications directory if it does not exist.

```bash
mkdir /usr/share/applications
```

```bash
mkdir /home/$USER/.local/share/applications
```

2. Symlink or copy the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/kitty /home/$USER/.config/
```

```bash
sudo cp -r /home/$USER/arch-hypr-dots/usr/share/applications/kitty.desktop /usr/share/applications/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/share/applications/kitty.desktop /home/$USER/.local/share/applications/
```

3. Update the desktop database.

```bash
update-desktop-database /home/$USER/.local/share/applications
```

---

### 6.9 Geany

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

### 6.10 Thunar

1. Create 0the xfce4 and helpers directories if it does not exist.

```bash
mkdir /home/$USER/.local/share/xfce4
```

```bash
mkdir /home/$USER/.local/share/xfce4/helpers
```

2. Symlink or copy the new files.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/share/xfce4/helpers/kitty.desktop /home/$USER/.local/share/xfce4/helpers/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/xfce4/helpers.rc /home/$USER/.config/xfce4/
```

---

### 6.11 Ani-cli

1. Remove the existing ani-hist file.

```bash
rm /home/$USER/.local/state/ani-cli/ani-hist
```

2. Create the ani-cli directory if it does not exist.

```bash
mkdir /home/$USER/.local/state/ani-cli
```

3. Symlink the new file.

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.local/state/ani-cli/ani-hist /home/$USER/.local/state/ani-cli/
```

#### 6.11.1 Modify Ani-cli update_history() function

1. Open the Ani-cli script with nvim (some installation might happen).

```bash
sudo nvim /usr/bin/ani-cli
```

2. Comment out the existing update_history() function.

3. Paste the below above the defalut function which is commented in the previous step.

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

4. Save and exit the file.

---

### 6.12 Feather

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/Feather /home/$USER/.config/
```

```bash
ln -s /home/$USER/arch-hypr-dots/home/user/.config/Feather/feather_frontend/target/release/feather_frontend /home/$USER/
```

---

### 6.13 Plymouth

#### 6.13.1 Modify the kernel parameters

1. Create the cmdline.d directory and arch.conf file if it does not exist.

```bash
sudo mkdir /etc/cmdline.d
```

```bash
sudo touch /etc/cmdline.d/arch.conf
```

2. Open the newly created file with nvim.

```bash
sudo nvim /etc/cmdline.d/arch.conf
```

3. Run the below command in a new terminal.

```bash
cat /etc/kernel/cmdline
```

4. Paste the below in the file and replace **\<output>** with the output from the previous command.

```
options <output> quiet splash
```

5. Save and exit the file.

#### 16.13.2 Add Plymouth to mkinitcpio.conf

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

#### 16.13.3 Set the theme

```bash
plymouth-set-default-theme -R arch-darwin
```

---

### 6.14 SDDM

1. Create the sddm.conf.d directory and the sddm.conf file.

```bash
sudo mkdir /etc/sddm.conf.d
```

```bash
sudo touch /etc/sddm.conf.d/sddm.conf
```

2. Copy the necessary directory.

```bash
sudo cp -r /home/clinton/arch-hypr-dots/usr/share/sddm/themes/Dr460nized /usr/share/sddm/themes/
```

#### 6.14.1 Modify sddm.conf

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

## 7. Complete the installation

Reboot your device to complete the install.
