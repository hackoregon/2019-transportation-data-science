#! /bin/bash

# define parameters
export raw="../../data/raw"

# unpack the raw data
pushd ${raw}
rm -f *.csv *.txt *.xlsx
echo "Unpacking the archive"
/usr/bin/time 7z e scrapes.rar
popd
