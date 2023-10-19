#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/xdg-desktop-portal-gnome -b 45.0
cp -rvf ./debian ./xdg-desktop-portal-gnome/
cp -rf ./patches/xdg-desktop-portal-gnome.service.in ./xdg-desktop-portal-gnome/data/ || true
cd ./xdg-desktop-portal-gnome/
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done


# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p xdg-desktop-portal-gnome_45.0
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
