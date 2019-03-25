FROM docker.io/library/postgres:10
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# Install apt packages
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
    inetutils-ping \
    postgresql-10-cstore-fdw \
    postgresql-10-ogr-fdw \
    postgresql-10-pgrouting \
    postgresql-10-pgrouting-doc \
    postgresql-10-pgrouting-scripts \
    postgresql-10-postgis-2.5 \
    postgresql-10-postgis-2.5-scripts \
    postgresql-client-10 \
    time \
  && apt-get clean
