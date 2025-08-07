#!/bin/bash

set -ouex pipefail

### Install Repos

dnf5 -y copr enable yalter/niri
dnf5 -y copr enable ulysg/xwayland-satellite
dnf5 -y copr enable trs-sod/swaylock-effects

### Dependency Groups

NIRI_DEPS=(
    niri
    fuzzel
    mako
    xwayland-satellite
    swaybg
)

ADDITIONAL_PACKAGES=(
    alacritty
)

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
    tmux \
    ${NIRI_DEPS[@]} \
    ${ADDITIONAL_PACKAGES[@]} \
 
dnf5 remove -y swaylock
dnf5 install -y swaylock-effects

### Disable Repositories

dnf5 -y copr disable yalter/niri
dnf5 -y copr disable ulysg/xwayland-satellite
dnf5 -y copr disable trs-sod/swaylock-effects

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
