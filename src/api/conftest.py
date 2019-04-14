import pytest
import os
import backend

@pytest.fixture(scope='session')
def django_db_setup():
    backend.settings.DATABASES['default'] = {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'NAME': os.environ.get('POSTGRES_NAME'),
        'USER': os.environ.get('POSTGRES_USER'),
        'HOST': os.environ.get('POSTGRES_HOST'),
        'PORT': os.environ.get('POSTGRES_PORT'),
        'CONN_MAX_AGE': 0,
        'OPTIONS': {
            'MAX_CONNS': 20
        }
    }