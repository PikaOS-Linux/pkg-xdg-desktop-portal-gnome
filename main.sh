#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/xdg-desktop-portal-gnome -b 45.0
cp -rvf ./debian ./xdg-desktop-portal-gnome/
cd ./xdg-desktop-portal-gnome/

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
