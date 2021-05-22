#! /bin/sh
set -e
export BUILDARCH=amd64
export BUILDFLAVOUR=mate
export BUILDLOG=quiet
lb build
