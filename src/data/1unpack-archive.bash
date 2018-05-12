#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
rm -f *.csv *.txt *.xlsx
echo "Unpacking the archive"
unrar e scrapes.rar
popd
