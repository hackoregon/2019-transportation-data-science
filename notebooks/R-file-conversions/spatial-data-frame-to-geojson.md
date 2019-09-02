Converting `sp` Spatial Data Frames to GeoJSON
================
M. Edward (Ed) Borasky

## Why would we do this?

There are two reasons we might want to do this:

1.  A user doesn’t have R and thus can’t do anything with an `sp` data
    frame, or
2.  We want to store the data frame in a database, and the database
    doesn’t have a way to read an R data file.

## Why GeoJSON?

1.  It’s a standard open source format.
2.  It can be easily read by `QGIS` and many JavaScript mapping tools.
3.  It can be uploaded to a PostGIS database.

## What libraries do we need?

``` r
library(sp)
library(readr)
library(rgdal)
```

    ## rgdal: version: 1.4-4, (SVN revision 833)
    ##  Geospatial Data Abstraction Library extensions to R successfully loaded
    ##  Loaded GDAL runtime: GDAL 3.0.1, released 2019/06/28
    ##  Path to GDAL shared files: 
    ##  GDAL binary built with GEOS: TRUE 
    ##  Loaded PROJ.4 runtime: Rel. 6.1.0, May 15th, 2019, [PJ_VERSION: 610]
    ##  Path to PROJ.4 shared files: (autodetected)
    ##  Linking to sp version: 1.3-1

## Read the R data frame

``` r
bus_stop_catchment_zone <- readr::read_rds("/Raw/busstop_catchment_zone_shp.RDS")
```

## Write the GeoJSON

``` r
rgdal::writeOGR(bus_stop_catchment_zone, 
                dsn = "/Work/bus_stop_catchment_zone.geojson", 
                layer = "bus_stop_catchment_zone", 
                driver = "GeoJSON",
                overwrite_layer = TRUE
)
```
