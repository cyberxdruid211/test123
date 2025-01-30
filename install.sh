#! /bin/bash
#
# Install script for SwiftlyGo
#

# detect compatible os and run install script
arch=$(uname -m)
arch_type=$(uname -m)
id=""
dist_ver=""
os_dir=""
os_file_name=""

case $arch in
    *x86_64*)
        arch=""
        ;;
    *aarch64*)
        arch="-aarch64"
        ;;
    *)
        echo "Sorry, you have an unsupported architecture"
        exit 1
        ;;
esac

if test -r /etc/os-release; then
. /etc/os-release

        case $ID in
            *elementary* | *pop* | *linuxmint* | *bianbu* | *zorin*)
                echo "$PRETTY_NAME is compatible with ubuntu/$UBUNTU_CODENAME"
                echo
                os_version=$UBUNTU_CODENAME
            ;;
            *ubuntu*)
                 os_version=$UBUNTU_CODENAME
            ;;
            *debian*)
                os_version=$VERSION_CODENAME
            ;;
            *)
                echo "sorry you have an unsupported operating system"; exit 1
            ;;
        esac
        # add cases for focal, jammy, noble, bookworm
        case $os_version in
                *focal*)
                id="ubuntu"
                dist_ver="Ubuntu 20.04"
                os_dir="ubuntu2004"
                os_file_name="ubuntu20.04"
                ;;
                *jammy*)
                id="ubuntu"
                dist_ver="Ubuntu 22.04"
                os_dir="ubuntu2204"
                os_file_name="ubuntu22.04"
                ;;
                *noble*)
                id="ubuntu"
                dist_ver="Ubuntu 24.04"
                os_dir="ubuntu2404"
                os_file_name="ubuntu24.04"
                ;;
                *bookworm*)
                id="debian"
                dist_ver="Debian 12"
                os_dir="debian12"
                os_file_name="debian12"
                ;;
        esac
else
    echo
    echo "sorry you have an unsupported system"
    echo
    exit 1
fi
# OS System is compatible with $dist_ver / $arch_type
echo
echo "OS System is compatible with $dist_ver / $arch_type"
echo
#
DOWNLOAD_URL="https://github.com/cyberxdruid211/test123/releases/download/v0.1a/swiftlygo-$arch_type"
DEST_DIR="/usr/libexec/swiftlygo/bin/"
EXECUTABLE_NAME="swiftlygo"
#
mkdir -p "$DEST_DIR"
# Save environment variables to .env file
cat << EOF > /usr/libexec/swiftlygo/bin/swiftlygo.env
DEFAULT_VER=6.0.3
URL_BASE=https://download.swift.org
SWIFT_VER=6.0.3
ID=$id
DIST_VER=$dist_ver
ARCH=$arch
ARCH_TYPE=$arch_type
OS_DIR=$os_dir
OS_FILE_NAME=$os_file_name
EOF

# Download swiftlygo and install
rm "$DEST_DIR/$EXECUTABLE_NAME"
curl -L "$DOWNLOAD_URL" -o "$DEST_DIR/$EXECUTABLE_NAME" && chmod +x "$DEST_DIR/$EXECUTABLE_NAME"
ln -sf /usr/libexec/swiftlygo/bin/swiftlygo /usr/bin/swiftlygo
# use this as an install method
# /usr/libexec/swiftlygo/bin/
# ├── swiftlygo
# └── swiftlygo.env
#
# sudo ln -sf /usr/libexec/swiftlygo/bin/swiftlygo /usr/bin/swiftlygo
