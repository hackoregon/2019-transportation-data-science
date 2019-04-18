# Preliminary install instructions

## Pipenv
The tutorials I'm using work with pipenv. That doesn't seem to be in most Linux distros, but it is in Arch Linux. So I'm using it.

## Basic scaffolding

```
mkdir -p toad_api
cd toad_api
pipenv install django psycopg2
pipenv shell
django-admin startproject toad_api_project .
django-admin startapp toad_api_app
```

You should now have a `settings.py` file in `toad_api_project`.

## Settings.py
First, restore the database to a PostGIS server accessible to your command line. On my machine my home account is a
database superuser, so I don't need to do much configuration in the database. Edit `toad_api_project/settings.py`:

1. Add `'django.contrib.gis',` at the bottom of `INSTALLED_APPS`.
2. Edit the DATABASES `default` entry. You will need at least

    ```
    'ENGINE': 'django.contrib.gis.db.backends.postgis',
    'NAME': 'transit_operations_analytics_data',
    ```

    and may need HOST, PORT, USER and PASSWORD.

Test by running `python manage.py migrate` and `python manage.by runserver`. You should be able to browse to the debug
page at http://127.0.0.1:8000.

## Inspecting the database
Django can inspect a database to give you a starting set of models. We'll use this, since our database has been
constructed from TriMet CSV files rather than via Django operations:

```
python manage.py inspectdb > models.py
```
