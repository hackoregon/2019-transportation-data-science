from django.contrib import admin
from civic_sandbox import models
from backend import settings

# Register your models here.

if settings.ENABLE_ADMIN_INTERFACE:
    admin.site.register(models.Packages)
    admin.site.register(models.Slide)
    admin.site.register(models.Foundation)
