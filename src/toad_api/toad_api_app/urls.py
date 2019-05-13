# toad_api_app/urls.py

from django.urls import path

from .views import BusAllStopsListView
from .views import BusPassengerStopsListView
from .views import BusTripsListView
from .views import RailPassengerStopsListView

urlpatterns = [
	path('', BusAllStopsListView.as_view(), name='bus_all_stops'),
	path('', BusPassengerStopsListView.as_view(), name='bus_passenger_stops'),
	path('', BusTripsListView.as_view(), name='bus_trips'),
	path('', RailPassengerStopsListView.as_view(), name='rail_passenger_stops'),
]

