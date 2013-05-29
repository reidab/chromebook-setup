#!/bin/sh -e

USER="reidab"
CHROOT_NAME=$USER
CHROOT_DIR="/usr/local/chroots/$CHROOT"
SCRIPT=$(readlink -f $0)
BASE=$(dirname $SCRIPT)
TEMP=$(mktemp -d)
WORK="$BASE/work"

echo "Fetching setup script..."
mkdir -p $WORK
wget https://api.github.com/repos/reidab/chromebook-setup/tarball -O "$TEMP/reidab-chromebook-setup.tar.gz"

echo "Fetching crouton..."
wget http://goo.gl/fd3zc -O "$TEMP/crouton"

echo "Extracting..."
sh -e "$TEMP/crouton" -x "$WORK"
tar xzf "$TEMP/reidab-chromebook-setup.tar.gz" -C $WORK --strip-components 1

echo "Looking for support on external media..."
EXT=$(find /media/removable -maxdepth 2 -name chromebook-setup -type d)
if [ ! -z $EXT ]; then
  echo "Found $EXT"
fi

# if [ -d "$CHROOT_DIR/home/$USER" ]; then
#   echo "Backing up existing home directory..."
#   mkdir -p $WORK/backups
#   tar czf $WORK/
# fi

sudo sh -e $WORK/installer/main.sh -n $CHROOT_NAME -t reidab

trap 'rm -rf "$TEMP" >/dev/null 2>&1' 0
trap "exit 2" 1 2 3 15
