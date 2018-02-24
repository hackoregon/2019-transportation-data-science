#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
echo "Unpacking the archive"
/usr/bin/time unrar e -inul scrapes.rar
popd
