#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
rm -f *.csv *.txt *.xlsx
echo "Unpacking the archive"
7z e scrapes.rar
popd
