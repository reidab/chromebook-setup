# Chromebook Setup

Notes and code for automating the setup of a Samsung Chromebook. 

This is mostly for my own use, so things will change wildly and without notice.

Most of the heavy lifting of building a Ubuntu-based chroot environment is done by [crouton](https://github.com/dnschneid/crouton), with a few convient wrappers and utilities thrown in to make things easier.

The files in this repo get merged with crouton's directory structure to produce a crouton environment with extra targets. This is a little whacky, but it works. (Originally, I had been hoping to use crouton's -T option (for passing in a target file), but its method of copying config files seems works best with files in its environment.)

## Code

### Installation

Download and run fetch.sh

    curl https://raw.github.com/reidab/chromebook-setup/master/fetch.sh | sh -e
    
This will create a chromebook-setup directory and extract both crouton and this repo's files into it.

Subsequent runs of fetch.sh from within the chromebook-setup directory will overwrite directory contents with updated versions.


### Crouton Targets

Crouton has a concept of _targets_, which define the install steps for a given bit of software.

This repo contains:

* awesome - Installs the [awesome](http://awesome.naquadah.org/) window manager
* reidab - Installs all the extra packages I want on my system

## Notes

### Snapshot chroot to tarball

    sudo tar -pc -C /usr/local/chroots --transform="s/^reidab/precise-armhf/" -f /media/removable/USB/chromebook-setup/snapshot.tar.gz reidab

Or verbosely:

    sudo tar -pvc -C /usr/local/chroots --transform="s/^reidab/precise-armhf/" --show-transformed-names -f /media/removable/USB/chromebook-setup/snapshot.tar.gz reidab

