# Hyprland dotfiles and configurations

## Contents

1. [Install Git and configure the default branch](#1-install-git-and-configure-the-default-branch)
2. [Clone the repository](#2-clone-the-repository)
3. [Run the install script](#3-run-the-install-script)
4. [Manual intervention](#4-manual-intervention)
5. [Complete the installation](#5-complete-the-installation)
6. [Tips and tricks](#6-tips-and-tricks)

> [!IMPORTANT]
>
> Assumes vanilla arch installation using arch install script with hyprland as the profile.
>
> Sudo privileges, and thus user input, will be required.

## 1. Install git and configure the default branch

```bash
sudo pacman -S --needed git
```

```bash
git config --global init.defaultBranch main
```

## 2. Clone the repository

```bash
git clone https://github.com/TheRealMDK/arch-hypr-dots.git /home/$USER/arch-hypr-dots
```

## 3. Run the install script

```bash
"$HOME/arch-hypr-dots/install.sh"
```

## 4. Manual intervention

### Ani-cli

To ensure the update_history function edits are made to the actual file target rather than the symlink itself, after the first restart after running the install.sh script, follow the steps below:

1. Open the ani-cli script with nvim (some installation might happen).

```bash
sudo nvim /usr/bin/ani-cli
```

2. Find and comment out the existing update_history() function.
3. Paste the below above or below the default function which is commented out in step 2.

```bash
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

### Plymouth

The plymouth hook must be added to '/etc/mkinitcpio.conf' before restarting.

To do this, follow the below steps:

1. Open the mkinitcpio.conf file with nvim.

```bash
sudo nvim /etc/mkinitcpio.conf
```

2. Add plymouth to the HOOKS array in mkinitcpio.conf.

```bash
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
> ```bash
> HOOKS=(base udev plymouth autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)
> ```

3. Save the file and exit.

## 5. Complete the installation

Ensure steps in the manual intervention section are performed, then reboot your device to complete the install.

## 6. Tips and tricks

> [!TIP]
>
> To select a different kitty theme run:
>
> ```bash
> kitty +kitten themes
> ```
>
> To select a different kitty font run:
>
> ```bash
> kitty +kitten choose-fonts
> ```
