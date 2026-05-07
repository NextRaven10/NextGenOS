#!/bin/bash

set -ouex pipefail

### Install packages

# VSCode package from Microsoft repo
echo "Installing VSCode from official repo..."
tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/vscode.repo
dnf -y install --enablerepo=code \
    code

# Install Hyprland dependencies
dnf install -y \
    waybar \
    rofi \
    cliphist

# Install more Hyprland stuff
# Install SwayNotificationCenter
dnf copr enable -y erikreider/SwayNotificationCenter
dnf install -y swaync
dnf copr disable -y erikreider/SwayNotificationCenter

# Install Hyprland via copr
dnf copr enable -y blacktau/hyprland
dnf install -y \
    aquamarine \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprsunset \
    hyprshot \
    nwg-clipman \
    xdg-desktop-portal-hyprland \
    hyprpolkitagent \
    mpvpaper
dnf copr disable -y blacktau/hyprland

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Reminder: Don't install packages via brew in the build phase

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
