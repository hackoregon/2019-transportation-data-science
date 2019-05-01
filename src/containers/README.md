# Quickstart

1. You do ***not*** need to create the API scaffolding! That's been done and checked into this repo!

2. `cp env.sample .env` in the root of the repo (this file is already in the `.gitignore`, so you should not have to worry about it getting accidentally checked into a GitHub repo)

3. Edit your `.env` file and change the passwords: `POSTGRES_PASSWORD`, `TEAM_PASSWORD` and `DJANGO_SECRET_KEY`.

```
PROJECT_NAME=transit_operations_analytics_data

# the database superuser name - this is the default
POSTGRES_USER=postgres

# the database name the API will connect to - "dbname" in most PostgreSQL command-line tools
POSTGRES_NAME=transit_operations_analytics_data

# the database owner - automatic restore needs this (most likely only used in dev)
DATABASE_OWNER=transportation2019

# *service* name (*not* image name) of the database in the Docker network
POSTGRES_HOST=db_development

# port the database is listening on in the Docker network
POSTGRES_PORT=5432

# password for the PostgreSQL database superuser in the database container
POSTGRES_PASSWORD=sit-down-c0mic

# the password for the teams
TEAM_PASSWORD=d0wn!0ff!a!duck

# Django secret key in the API container
DJANGO_SECRET_KEY=r0ck.ar0und.the.c10ck
```

4. Copy your database backup file into the `Backups` folder. Database container is a PostGIS-enabled 11 container. Note that the 
current backup is 7 gigabytes and it restores to about a 36 gigabyte tablespace. If your container storage is on a small SSD you may
be unable to run this!! And it takes a ***long*** time to restore!

5. Run the `bin/build.sh` script to build the project. Since you are going to be running it on the local machine you will want to run: `./bin/build.sh -d`, this command is doing a docker-compose build in the background. It is downloading the images needed for the project to your local machine.

6. Once this completes you will now want to start up the project. We will use the `start.sh` script for this, again using the `-d` flag to run locally:  `./bin/start.sh -d` The first time you run this you will see the database restores. You will also see the api container start up.

7. Create your api code. Checkout the [Django REST framework Guide](http://www.django-rest-framework.org/) on how to proceed.

## Contributors and History

This repo represents the work of many members of the Hack Oregon project team. The roots of this work began with the [2017 backend-service-pattern](https://github.com/hackoregon/backend-service-pattern), the work of the DevOps and platform teams, and the APIs deployed for the 2017 seasons.

This current implementation builds on the [transportation-system-backend](https://github.com/hackoregon/transportation-system-backend) and [passenger_census_api](https://github.com/hackoregon/passenger_census_api). The database structure is an implementation of the PostGIS container of the **data-science-pet-containers** repo.

### Major Contributors

* M. Edward (Ed) Borasky ([znmeb](https://github.com/znmeb)),
* Brian Grant ([bhgrant8](https://github.com/bhgrant8), [BrianHGrant](https://github.com/BrianHGrant)),
* Adi Kini ([kiniadit](https://github.com/kiniadit)),
* Mike Lonergan ([mikethecanuck](https://github.com/mikethecanuck)),
* Alec Peters ([adpeters](https://github.com/adpeters)),
* Nathan Miller ([nam20485](https://github.com/nam20485)).
