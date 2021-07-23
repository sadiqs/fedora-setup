Update & Upgrade (DO FIRST):
sudo dnf upgrade --refresh

Enable RPM Fusion:

Install NVIDIA Drivers:
https://rpmfusion.org/Howto/NVIDIA

Install Favorite Apps:
sudo dnf install vlc gimp gparted kdenlive

Install GNOME Tweak Tool:
sudo dnf install gnome-tweak-tool

Install Timeshift backup:
sudo dnf install timeshift

Install Preload:
sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y

Firefox Tweaks:
about:config
layers.acceleration.force-enabled
gfx.webrender.all

Change DNS:
8.8.8.8,8.8.4.4

Speed up DNF:
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

Install DNFDragora:
sudo dnf isntall dnfdragora

Install GNOME Extensions:
dnf install chrome-gnome-shell gnome-extensions-app

Install KDEConnect:
sudo dnf install kdeconnectd

Install Steam:
sudo dnf install steam

Better Fonts:
sudo dnf copr enable dawid/better_fonts -y
sudo dnf install fontconfig-font-replacements -y
sudo dnf install fontconfig-enhanced-defaults -y

Install Bleachbit:
sudo dnf install bleachbit

Add below lines to NetworkManager.conf

```
[device]
wifi.scan-rand-mac-address=no
```
