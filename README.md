Aptly for Docker
================

This repo container Docker configurations to deploy and use Aptly. Most
use cases will require you to extend these containers with your own
configuration file overlay.

Makefile commands
=================

Default REPO=/tmp/aptly

`make` will build image and run container with defaults

`make build` will build image

`make run` will run container with defaults

`REPO=/path/to/my/repo make run` will mount existing repo as volume

Docker CLI
==========

Start docker with no persistence

    docker run -it --rm -name aptly_docker digibib/aptly:latest /bin/bash

If you'd like to persist any changes made past the lifetime of the container, 
mount the aptly data directory externally:

    # create a directory on host for repo
    mkdir /tmp/aptly
    # start container and mount as volume
    docker run -it --rm --name aptly_docker -v /tmp/aptly:/aptly digibib/aptly:latest /bin/bash

# Example process

The following will be executed inside container

## Create Repo

    aptly repo create foo

## Add packages

Add packages to /tmp/aptly/build

    # with .changes file
    aptly repo include -accept-unsigned=true -repo=deichmankoha /aptly/build

    # or directory with .deb files
    aptly repo include -accept-unsigned=true -repo=deichmankoha /aptly/build

## Create snapshot

    # create snapshot
    aptly snapshot create koha-stable from repo deichmankoha

## Publish

    # publish snapshot
    aptly publish snapshot -architectures=amd64 koha-stable
