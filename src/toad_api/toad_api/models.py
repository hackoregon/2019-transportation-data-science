# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class BusAllStops(models.Model):
    vehicle_id = models.IntegerField(blank=True, null=True)
    opd_date = models.DateField(blank=True, null=True)
    act_arr_time = models.DateTimeField(blank=True, null=True)
    act_dep_time = models.DateTimeField(blank=True, null=True)
    nom_arr_time = models.DateTimeField(blank=True, null=True)
    nom_dep_time = models.DateTimeField(blank=True, null=True)
    event_no_trip = models.IntegerField(blank=True, null=True)
    meters = models.IntegerField(blank=True, null=True)
    stop_id = models.IntegerField(blank=True, null=True)
    stop_pos = models.IntegerField(blank=True, null=True)
    distance_to_next = models.IntegerField(blank=True, null=True)
    distance_to_trip = models.IntegerField(blank=True, null=True)
    doors_opening = models.IntegerField(blank=True, null=True)
    stop_type = models.IntegerField(blank=True, null=True)
    door_open_time = models.IntegerField(blank=True, null=True)
    geom_point_4326 = models.TextField(blank=True, null=True)  # This field type is a guess.
    pkey = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'bus_all_stops'


class BusPassengerStops(models.Model):
    vehicle_id = models.IntegerField(blank=True, null=True)
    service_date = models.DateField(blank=True, null=True)
    arrive_time = models.DateTimeField(blank=True, null=True)
    leave_time = models.DateTimeField(blank=True, null=True)
    stop_time = models.DateTimeField(blank=True, null=True)
    route_number = models.IntegerField(blank=True, null=True)
    direction = models.IntegerField(blank=True, null=True)
    location_id = models.IntegerField(blank=True, null=True)
    dwell = models.IntegerField(blank=True, null=True)
    door = models.IntegerField(blank=True, null=True)
    lift = models.IntegerField(blank=True, null=True)
    ons = models.IntegerField(blank=True, null=True)
    offs = models.IntegerField(blank=True, null=True)
    estimated_load = models.IntegerField(blank=True, null=True)
    train_mileage = models.FloatField(blank=True, null=True)
    geom_point_4326 = models.TextField(blank=True, null=True)  # This field type is a guess.
    pkey = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'bus_passenger_stops'


class BusTrips(models.Model):
    vehicle_id = models.IntegerField(blank=True, null=True)
    opd_date = models.DateField(blank=True, null=True)
    act_dep_time = models.DateTimeField(blank=True, null=True)
    act_end_time = models.DateTimeField(blank=True, null=True)
    nom_dep_time = models.DateTimeField(blank=True, null=True)
    nom_end_time = models.DateTimeField(blank=True, null=True)
    event_no = models.IntegerField(blank=True, null=True)
    meters = models.IntegerField(blank=True, null=True)
    line_id = models.IntegerField(blank=True, null=True)
    pattern_direction = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'bus_trips'


class RailPassengerStops(models.Model):
    vehicle_id = models.IntegerField(blank=True, null=True)
    service_date = models.DateField(blank=True, null=True)
    arrive_time = models.DateTimeField(blank=True, null=True)
    leave_time = models.DateTimeField(blank=True, null=True)
    stop_time = models.DateTimeField(blank=True, null=True)
    route_number = models.IntegerField(blank=True, null=True)
    direction = models.IntegerField(blank=True, null=True)
    location_id = models.IntegerField(blank=True, null=True)
    dwell = models.IntegerField(blank=True, null=True)
    door = models.IntegerField(blank=True, null=True)
    lift = models.IntegerField(blank=True, null=True)
    ons = models.IntegerField(blank=True, null=True)
    offs = models.IntegerField(blank=True, null=True)
    estimated_load = models.IntegerField(blank=True, null=True)
    train_mileage = models.FloatField(blank=True, null=True)
    geom_point_4326 = models.TextField(blank=True, null=True)  # This field type is a guess.
    pkey = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'rail_passenger_stops'


class SpatialRefSys(models.Model):
    srid = models.IntegerField(primary_key=True)
    auth_name = models.CharField(max_length=256, blank=True, null=True)
    auth_srid = models.IntegerField(blank=True, null=True)
    srtext = models.CharField(max_length=2048, blank=True, null=True)
    proj4text = models.CharField(max_length=2048, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'spatial_ref_sys'


class Weekdays(models.Model):
    date_stamp = models.DateField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'weekdays'
