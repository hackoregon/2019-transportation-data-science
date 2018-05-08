#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
echo "Unpacking the archive"
7z e scrapes.rar
dos2unix *.csv
popd
