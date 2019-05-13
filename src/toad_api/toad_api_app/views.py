from django.shortcuts import render

# Create your views here.
from django.views.generic import ListView

from .models import BusAllStops
from .models import BusPassengerStops
from .models import BusTrips
from .models import RailPassengerStops

class BusAllStopsListView(ListView):
	model = BusAllStops
        template_name = 'bus_all_stops_list.html'
class BusPassengerStopsListView(ListView):
	model = BusPassengerStops
        template_name = 'bus_passenger_stops_list.html'
class BusTripsListView(ListView):
	model = BusTrips
        template_name = 'bus_trips_list.html'
class RailPassengerStopsListView(ListView):
	model = RailPassengerStops
        template_name = 'rail_passenger_stops_list.html'
