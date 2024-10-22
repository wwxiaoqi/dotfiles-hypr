# My Hyprland Dotfiles

## 使用方法
本仓库使用 chezmoi 作为 dotfiles 管理工具，具体请看：[General-purpose dotfiles utilities](https://dotfiles.github.io/utilities/)。

在全新设备上安装 chezmoi 后执行以下内容：

```shell
chezmoi init --apply https://github.com/wwxiaoqi/dotfiles-hypr
```


## 安装

### 常用工具

```shell
sudo pacman -S vim neovim fzf tmux git rsync openssh zip unzip tree pacman-contrib archlinux-contrib arch-install-scripts arch-wiki-docs dosfstools bash-completion
```

### 系统配置

```shell
sudo pacman -S networkmanager brightnessctl tlp ntp ufw firejail fail2ban cronie iwd daed dhcpcd
```

### 驱动

```shell
sudo pacman -S amd-ucode libva-mesa-driver nvidia-dkms nvidia-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack xf86-video-vesa xdg-desktop-portal xdg-desktop-portal-hyprland wlroots
```

### 系统监控

```shell
sudo pacman -S btop ncdu sysstat smartmontools nvtop
```

### 浏览器

```shell
sudo pacman -S w3m firefox firefox-dark-reader firefox-tridactyl firefox-ublock-origin vivaldi vivaldi-ffmpeg-codecs
```

```shell
yay -S google-chrome tor-browser-bin
```

### 蓝牙

```shell
yay -S bluetuith
```

### 窗口管理器

```shell
sudo pacman -S foot hypridle hyprland hyprlock mako waybar wev fish wmenu wtype wl-clipboard cliphist gammastep slurp grim gimp wf-recorder 
```

```shell
yay -S ranger-git brn2-git
```

### 主题

```shell
sudo pacman -S adwaita-qt5 adwaita-qt6 qt5ct qt6ct lxappearance
```

### 字体

```shell
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic noto-fonts-extra otf-font-awesome ttf-dejavu ttf-font-awesome ttf-joypixels ttf-nerd-fonts-symbols ttf-sarasa-gothic
```

### 文件浏览

```shell
sudo pacman -S imv zathura zathura-pdf-mupdf
```

### 多媒体编辑器

```shell
sudo pacman -S ffmpeg iffmpegthumbnailer id3v2 imagemagick mediainfo perl-image-exiftool perl-rename 
```

### 输入法引擎

```shell
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
```

```shell
yay -S rime-frost-git
```

### 配置 Rime

```shell
vim $HOME/.local/share/fcitx5/rime/default.custom.yaml
```

```yaml
patch:
  # 候选词数量设置
  "menu/page_size": 9

  # 仅使用「雾凇拼音」的默认配置，配置此行即可
  __include: rime_ice_suggestion:/

  # 以下可根据自己所需进行自定义，仅做参考。
  # 仅针对「雾凇输入法」的定制条目，请在 rime_ice.custom.yaml 中配置
  __patch:

    # 以词定字（上屏当前词组的第一个或最后一个字）
    key_binder/+:
      select_first_character: "bracketleft" # 即 [
      select_last_character: "bracketright" # 即 ]
```

### 工具

```shell
sudo pacman -S neomutt newsboat
```

### 编程

```shell
sudo pacman -S jdk-openjdk openjdk-src
```

```shell
yay -S visual-studio-code-bin
```


## 配置

### 配置 pacman

通过 `pacman-contrib` 包中的 `paccache` 命令删除未使用的包（默认保留包的最后 3 个版本）

```shell
systemctl enable --now paccache.timer
```
