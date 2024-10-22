# My Hyprland Dotfiles

## Usage method
This repository uses chezmoi as the dotfiles management tool. For specific information, please refer to: [General-purpose dotfiles utilities](https://dotfiles.github.io/utilities/).

After installing chezmoi on a brand new device, execute the following:

```shell
chezmoi init --apply https://github.com/wwxiaoqi/dotfiles-hypr
```


## Installation

### Common tools

```shell
sudo pacman -S vim neovim fzf tmux git rsync openssh zip unzip tree pacman-contrib archlinux-contrib arch-install-scripts arch-wiki-docs dosfstools bash-completion
```

### System configuration

```shell
sudo pacman -S networkmanager brightnessctl tlp ntp ufw firejail fail2ban cronie iwd daed dhcpcd
```

### Drives

```shell
sudo pacman -S amd-ucode libva-mesa-driver nvidia-dkms nvidia-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack xf86-video-vesa xdg-desktop-portal xdg-desktop-portal-hyprland wlroots
```

### System monitoring

```shell
sudo pacman -S btop ncdu sysstat smartmontools nvtop
```

### Browser

```shell
sudo pacman -S w3m firefox firefox-dark-reader firefox-tridactyl firefox-ublock-origin vivaldi vivaldi-ffmpeg-codecs
```

```shell
yay -S google-chrome tor-browser-bin
```

### Bluetooth

```shell
yay -S bluetuith
```

### Window Manager

```shell
sudo pacman -S foot hypridle hyprland hyprlock mako waybar wev fish wmenu wtype wl-clipboard cliphist gammastep slurp grim gimp wf-recorder 
```

```shell
yay -S ranger-git brn2-git
```

### Theme

```shell
sudo pacman -S adwaita-qt5 adwaita-qt6 qt5ct qt6ct lxappearance
```

### Fonts

```shell
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic noto-fonts-extra otf-font-awesome ttf-dejavu ttf-font-awesome ttf-joypixels ttf-nerd-fonts-symbols ttf-sarasa-gothic
```

### File browsing

```shell
sudo pacman -S imv zathura zathura-pdf-mupdf
```

### Multimedia Editor

```shell
sudo pacman -S ffmpeg iffmpegthumbnailer id3v2 imagemagick mediainfo perl-image-exiftool perl-rename 
```

### Input Method Engine

```shell
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
```

```shell
yay -S rime-frost-git
```

### Configure Rime

```shell
vim $HOME/.local/share/fcitx5/rime/default.custom.yaml
```

```yaml
patch:
  # Candidate word quantity setting
  "menu/page_size": 9

  # Only use the default configuration of "rime pinyin" to configure this line
  __include: rime_ice_suggestion:/

  # The following can be customized according to your own needs, for reference only.
  # For customized entries only for the "rime input method", please configure them in rim_ice.customy.yaml
  __patch:

    # Defining words by word (the first or last word of the current phrase on the screen)
    key_binder/+:
      select_first_character: "bracketleft" # That is [
      select_last_character: "bracketright" # That is ]
```

### Tools

```shell
sudo pacman -S neomutt newsboat
```

### Code

```shell
sudo pacman -S jdk-openjdk openjdk-src
```

```shell
yay -S visual-studio-code-bin
```


## Configure

### Configure Pacman

remove unused packages weekly by `paccache` command from `pacman-contrib` package. (default keeps the last 3 versions of a package)

```shell
systemctl enable --now paccache.timer
```
