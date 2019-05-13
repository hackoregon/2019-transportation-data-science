from django.contrib import admin

# Register your models here.

from .models import BusAllStops
from .models import BusPassengerStops
from .models import BusTrips
from .models import RailPassengerStops

admin.site.register(BusAllStops)
admin.site.register(BusPassengerStops)
admin.site.register(BusTrips)
admin.site.register(RailPassengerStops)
