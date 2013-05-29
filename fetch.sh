#!/bin/sh -e
# Fetches crouton and Reid's chromebook setup scripts, extracts to merged directory

SCRIPT=$(readlink -f $0)
BASE=$(dirname $SCRIPT)
TEMP=$(mktemp -d)
WORK=$BASE

if [ ! -e $SCRIPT ]; then
  echo "Initial setup: creating workspace"
  WORK="$BASE/chromebook-setup"
  mkdir -p $WORK
fi

echo "Fetching setup script..."
wget https://api.github.com/repos/reidab/chromebook-setup/tarball -O "$TEMP/reidab-chromebook-setup.tar.gz"

echo "Fetching crouton..."
wget http://goo.gl/fd3zc -O "$TEMP/crouton"

echo "Extracting..."
sh -e "$TEMP/crouton" -x "$WORK"
tar xzf "$TEMP/reidab-chromebook-setup.tar.gz" -C $WORK --strip-components 1

trap 'rm -rf "$TEMP" >/dev/null 2>&1' 0
trap "exit 2" 1 2 3 15

