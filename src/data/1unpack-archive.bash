#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
echo "Unpacking the archive"
7z e -y scrapes.rar
popd
