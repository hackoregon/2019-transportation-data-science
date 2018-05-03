#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
echo "Unpacking the archive"
time 7z e scrapes.rar
popd
