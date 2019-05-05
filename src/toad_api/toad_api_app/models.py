# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.contrib.gis.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


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
    geom_point_4326 = models.PointField(blank=True, null=True)
    id = models.BigIntegerField(primary_key=True)

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
    geom_point_4326 = models.PointField(blank=True, null=True)
    id = models.BigIntegerField(primary_key=True)

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
    event_no_trip = models.IntegerField(blank=True, null=True)
    meters = models.IntegerField(blank=True, null=True)
    line_id = models.IntegerField(blank=True, null=True)
    pattern_direction = models.TextField(blank=True, null=True)
    id = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'bus_trips'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


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
    geom_point_4326 = models.PointField(blank=True, null=True)
    id = models.BigIntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'rail_passenger_stops'
