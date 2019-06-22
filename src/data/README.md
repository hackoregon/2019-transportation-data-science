# Database creation scripts

## LODES
First, `LODES` data must be downloaded and placed in `<ROOT> / data / external / LODES` folder. See `./lodes-download/download-raw-mac.bash` or `./lodes-download/download-raw.bash`. The `mac` version will put the data in the right place, the other file will put them in your home directory and you will need to move them.

`make_dataset_lodes.py` will stack the files for a corresponding datatype (`od`, `rac`, `wac`, `xwalk`), then convert them from wide into long format. This takes a good amount of time. 

For `OR` expect the following file sizes:
  - `od`    ~ 3.73 gb
  - `rac`   ~ 4.36 gb
  - `wac`   ~ 2.17 gb
  - `xwalk` ~ 316 mb
  
See also `make_dataset_lodes_dev.ipynb` for the notebook used to develop this script. Consider this an alpha version.
