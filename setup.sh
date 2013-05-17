#! /bin/sh -e

SCRIPT=$(readlink -f $0)
BASE=$(dirname $SCRIPT)
TEMP=$(mktemp -d)
WORK="$BASE/work"

mkdir -p $WORK
wget https://api.github.com/repos/reidab/chromebook-setup/tarball -O "$TEMP/reidab-chromebook-setup.tar.gz"
wget http://goo.gl/fd3zc -O "$TEMP/crouton"
sh -e "$TEMP/crouton" -x "$WORK"
tar xzf "$TEMP/reidab-chromebook-setup.tar.gz" -C $WORK --strip-components 1

sudo sh -e $WORK/installer/main.sh -n reidab -t reidab

trap 'rm -rf "$TEMP" >/dev/null 2>&1' 0
trap "exit 2" 1 2 3 15
