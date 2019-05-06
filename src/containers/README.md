# TOAD API Development Containers

## Introduction
This started with a clone of <git@github.com:hackoregon/backend-examplar-2018.git>. Then I ran the `create-api-project.sh`
script. This surfaced two problems:

1. It copies *everything* in this directory onto the API image, including the 7 gigabyte TOAD database backup! (ouch).
2. After building the API image, it runs it. The first thing the API container does is loop waiting for the database container to
come up. But we never *built* the database container or started it. And even if we had, it takes a long time to restore the backup!

So I made a new Dockerfile and compose file and rewrote `create-api-project.sh` to use them. That solves problem 2, and you now have
a Django project and an API app. You don't need to make those again, although you'll probably need to edit them.

Problem 1 was easy - just make the COPY operations specifically copy only relevant files in `DOCKERFILE.api.development`.

## Other notes
1. I updated the database image to PostgreSQL 11 and PostGIS 2.5. That's what we're using on AWS this season.
2. I didn't change any of the Python versions on the API image - we'll get that sorted out after we have a working API. I did update
the PostgreSQL client on the API image to PostgreSQL 11, since a 9.6 client won't work with an 11 database.
3. I removed most of the production infrastructure. We'll get that sorted out when we have a working API.

## Quickstart
1. ***You do not need to create the API scaffolding! That's been done and checked into this repo!***
2. `cp env.sample .env` in the root of the repo. `.env` is in the `.gitignore`, so it won't get accidentally checked into GitHub.
3. Edit your `.env` file and change the passwords: `POSTGRES_PASSWORD`, `TEAM_PASSWORD` and `DJANGO_SECRET_KEY`. The other environment
variables are already set to their correct values.

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

4. Copy your database backup file into the `Backups` folder. The database container is a PostGIS-enabled 11 container. Note that the 
current backup is 7 gigabytes and it restores to about a 36 gigabyte tablespace. If your container storage is on a small SSD you may
be unable to run this!! And it takes a ***long*** time to restore! I'm going to add a host data volume capability in a day or so.

5. Run the `bin/build.sh` script to build the project. Since you are going to be running it on the local machine you will want to 
run `./bin/build.sh -d`. This script does a `docker-compose build`, which downloads the images needed for the project to your local 
machine and builds the development environment images.

6. Once this completes you will now want to start up the project. We will use the `start.sh` script for this, again using the `-d` 
flag to run locally:  `./bin/start.sh -d`. The first time you run this you will see the database restores. As noted above, the
backup is 7 gigabytes and the restored database occupies about 36 gigabytes. You will also see the api container start up and loop
waiting for the database restore. When it's done you'll see

```
api_development_1  | Run server...
api_development_1  | Performing system checks...
api_development_1  | 
api_development_1  | System check identified no issues (0 silenced).
api_development_1  | (0.005) 
api_development_1  |             SELECT c.relname, c.relkind
api_development_1  |             FROM pg_catalog.pg_class c
api_development_1  |             LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
api_development_1  |             WHERE c.relkind IN ('r', 'v')
api_development_1  |                 AND n.nspname NOT IN ('pg_catalog', 'pg_toast')
api_development_1  |                 AND pg_catalog.pg_table_is_visible(c.oid); args=None
api_development_1  | (0.001) SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"; args=()
api_development_1  | May 01, 2019 - 07:09:53
api_development_1  | Django version 2.0.8, using settings 'transit_operations_analytics_data.settings'
api_development_1  | Starting development server at http://0.0.0.0:8000/
api_development_1  | Quit the server with CONTROL-C.
```

You can then browse to <http://0.0.0.0:8000/> and view the Django install success page. Then shut down with *one* `CONTROL-C`.

7. Create your api code. Checkout the [Django REST framework Guide](http://www.django-rest-framework.org/) on how to proceed. As long
as you haven't destroyed the containers or images, you won't need to re-run that database restore!

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
