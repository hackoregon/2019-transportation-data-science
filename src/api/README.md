# Transit Operations Analytics Data (TOAD) 2019 Backend Applicaton Server

Backend API application server written in Django + Django REST Framework application to serve disaster data from a postgreSQL database through a REST API.

## Description

When run, the application provides an http endpoint on the local system that serves the API via REST. The application can be run in two environments. For the development environment two Docker images that can be built and run are provided. The first image is the API application while the second is the postgreSQL database from which the API application serves data. For production envrionments a single image is provided, intended to allow the API application to be run on a web server instance such as AWS and connect to an existing postgreSQL database as the data source. Once built, the images can be started by running `bin/start.sh` and specifying either the `-d` (development) or `-p` (production) arguments.

## Usage

### Development

Before running the development server application, the database must be restored from a backup file and the Docker images must be built.

1. Copy `toad.env` to `.env`:
```
$ cp ./toad.env ./.env
```
2. Place copy of the TOAD database backup (transit_operations_analytics_data.sql.gz) in the `Backups/` directory.
3. Execute the start script with `-d` to (build and) start the images: 
```
$ bin/start.sh -d
```
The images will then build for a few minutes. Once the API application has completed starting up, you will see the following message:
```
Django application has started. Browse to 0.0.0.0:8000 to see the API.
``` 

At this point the API is exposed at an endpoint on your local machine; point a client at or browse to 0.0.0.0:8000/api to use/see the API and 0.0.0.0:8000/schema to see the schema. To stop the server and images, press CTRL+C and wait a moment for the images to shut down.

## History

This repo represents the work of many members of the Hack Oregon project team. The roots of this work began with the [2017 backend-service-pattern](https://github.com/hackoregon/backend-service-pattern), the work of the DevOps and platform teams, and the APIs deployed for the 2017 seasons.

The current implementation's application and database docker images were generated from the [backend-exemplar-2018](https://github.com/hackoregon/backend-exemplar-2018) repo, which is based on the [transportation-system-backend](https://github.com/hackoregon/transportation-system-backend) and [passenger_census_api](https://github.com/hackoregon/passenger_census_api) repos. The database structure is an implementation of the PostGIS container from the [data-science-pet-containers](https://github.com/hackoregon/data-science-pet-containers) repo.

2019 update: this is an interim hack, not the finished project! I started with last year's Disaster Resilience repo and modified stuff for the new database. There will be kittens and unicorns later. znmeb

Changes so far:
1. New database - code to make it is in ../data.
2. New environment variable file - toad.env
3. Development DB container updated to PostgreSQL 10 / PostGIS 2.5, and pgRouting has been removed.

## Major Contributors

* Nathan Miller ([nam20485](https://github.com/nam20485))
* M. Edward (Ed) Borasky ([znmeb](https://github.com/znmeb))
* Moss Drake ([mxmoss](https://github.com/mxmoss))
* Brian Grant ([bhgrant8](https://github.com/bhgrant8), [BrianHGrant](https://github.com/BrianHGrant))
* Mike Lonergan ([mikethecanuck](https://github.com/mikethecanuck))
