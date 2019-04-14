from django.contrib import admin
from api import preexisting_models
from backend import settings

# Register your models here.

if settings.ENABLE_ADMIN_INTERFACE:
    admin.site.register(preexisting_models.NeighborhoodUnits)
