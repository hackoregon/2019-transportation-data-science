# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from __future__ import unicode_literals

from django.db import models
from django.contrib.gis.db.models.fields import GeometryField


# class AuthGroup(models.Model):
#     name = models.CharField(unique=True, max_length=80)

#     class Meta:
#         managed = False
#         db_table = 'auth_group'


# class AuthGroupPermissions(models.Model):
#     group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
#     permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

#     class Meta:
#         managed = False
#         db_table = 'auth_group_permissions'
#         unique_together = (('group', 'permission'),)


# class AuthPermission(models.Model):
#     name = models.CharField(max_length=255)
#     content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
#     codename = models.CharField(max_length=100)

#     class Meta:
#         managed = False
#         db_table = 'auth_permission'
#         unique_together = (('content_type', 'codename'),)


# class AuthUser(models.Model):
#     password = models.CharField(max_length=128)
#     last_login = models.DateTimeField(blank=True, null=True)
#     is_superuser = models.BooleanField()
#     username = models.CharField(unique=True, max_length=150)
#     first_name = models.CharField(max_length=30)
#     last_name = models.CharField(max_length=150)
#     email = models.CharField(max_length=254)
#     is_staff = models.BooleanField()
#     is_active = models.BooleanField()
#     date_joined = models.DateTimeField()

#     class Meta:
#         managed = False
#         db_table = 'auth_user'


# class AuthUserGroups(models.Model):
#     user = models.ForeignKey(AuthUser, models.DO_NOTHING)
#     group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

#     class Meta:
#         managed = False
#         db_table = 'auth_user_groups'
#         unique_together = (('user', 'group'),)


# class AuthUserUserPermissions(models.Model):
#     user = models.ForeignKey(AuthUser, models.DO_NOTHING)
#     permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

#     class Meta:
#         managed = False
#         db_table = 'auth_user_user_permissions'
#         unique_together = (('user', 'permission'),)


class BuildingFootprints(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    bldg_id = models.CharField(max_length=80, blank=True, null=True)
    state_id = models.CharField(max_length=80, blank=True, null=True)
    bldg_numb = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    bldg_stat = models.CharField(max_length=80, blank=True, null=True)
    bldg_name = models.CharField(max_length=80, blank=True, null=True)
    bldg_addr = models.CharField(max_length=80, blank=True, null=True)
    bldg_type = models.CharField(max_length=80, blank=True, null=True)
    bldg_use = models.CharField(max_length=80, blank=True, null=True)
    bldg_sqft = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    sqft_src = models.CharField(max_length=80, blank=True, null=True)
    num_story = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    story_src = models.CharField(max_length=80, blank=True, null=True)
    units_res = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    units_src = models.CharField(max_length=80, blank=True, null=True)
    occup_cap = models.CharField(max_length=80, blank=True, null=True)
    occup_src = models.CharField(max_length=80, blank=True, null=True)
    ada_access = models.CharField(max_length=80, blank=True, null=True)
    year_built = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    struc_type = models.CharField(max_length=80, blank=True, null=True)
    struc_cond = models.CharField(max_length=80, blank=True, null=True)
    source = models.CharField(max_length=80, blank=True, null=True)
    source_ref = models.CharField(max_length=80, blank=True, null=True)
    avg_height = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    max_height = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    min_height = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    height_src = models.CharField(max_length=80, blank=True, null=True)
    surf_elev = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    surf_off = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    surf_adj = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    surf_src = models.CharField(max_length=80, blank=True, null=True)
    roof_elev = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    roof_type = models.CharField(max_length=80, blank=True, null=True)
    orient = models.CharField(max_length=80, blank=True, null=True)
    volume = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    shape_leng = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    shape_area = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    propkey = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    edit_stat = models.CharField(max_length=80, blank=True, null=True)
    data_sourc = models.CharField(max_length=80, blank=True, null=True)
    retired_by = models.CharField(max_length=80, blank=True, null=True)
    retired_da = models.CharField(max_length=80, blank=True, null=True)
    wkb_geometry = GeometryField()

    class Meta:
        managed = False
        db_table = 'building_footprints'


class CensusBgAoi(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    statefp = models.CharField(max_length=2, blank=True, null=True)
    countyfp = models.CharField(max_length=3, blank=True, null=True)
    tractce = models.CharField(max_length=6, blank=True, null=True)
    blkgrpce = models.CharField(max_length=1, blank=True, null=True)
    geoid = models.CharField(max_length=12, blank=True, null=True)
    namelsad = models.CharField(max_length=13, blank=True, null=True)
    mtfcc = models.CharField(max_length=5, blank=True, null=True)
    funcstat = models.CharField(max_length=1, blank=True, null=True)
    aland = models.DecimalField(max_digits=18, decimal_places=0, blank=True, null=True)
    awater = models.DecimalField(max_digits=18, decimal_places=0, blank=True, null=True)
    intptlat = models.CharField(max_length=11, blank=True, null=True)
    intptlon = models.CharField(max_length=12, blank=True, null=True)
    bg_areasqk = models.DecimalField(max_digits=19, decimal_places=6, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'census_bg_aoi'


class CommunityCenters(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    siteid = models.DecimalField(max_digits=4, decimal_places=0, blank=True, null=True)
    name = models.CharField(max_length=50, blank=True, null=True)
    address = models.CharField(max_length=50, blank=True, null=True)
    address2 = models.CharField(max_length=50, blank=True, null=True)
    city = models.CharField(max_length=30, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zipcode = models.CharField(max_length=5, blank=True, null=True)
    zip4 = models.CharField(max_length=4, blank=True, null=True)
    county = models.CharField(max_length=20, blank=True, null=True)
    phone = models.CharField(max_length=12, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    web_url = models.CharField(max_length=100, blank=True, null=True)
    owner = models.CharField(max_length=80, blank=True, null=True)
    manager = models.CharField(max_length=80, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'community_centers'


class CountiesAoi(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, blank=True, null=True)
    key = models.CharField(max_length=32, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'counties_aoi'


# class DjangoAdminLog(models.Model):
#     action_time = models.DateTimeField()
#     object_id = models.TextField(blank=True, null=True)
#     object_repr = models.CharField(max_length=200)
#     action_flag = models.SmallIntegerField()
#     change_message = models.TextField()
#     content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
#     user = models.ForeignKey(AuthUser, models.DO_NOTHING)

#     class Meta:
#         managed = False
#         db_table = 'django_admin_log'


# class DjangoContentType(models.Model):
#     app_label = models.CharField(max_length=100)
#     model = models.CharField(max_length=100)

#     class Meta:
#         managed = False
#         db_table = 'django_content_type'
#         unique_together = (('app_label', 'model'),)


# class DjangoMigrations(models.Model):
#     app = models.CharField(max_length=255)
#     name = models.CharField(max_length=255)
#     applied = models.DateTimeField()

#     class Meta:
#         managed = False
#         db_table = 'django_migrations'


# class DjangoSession(models.Model):
#     session_key = models.CharField(primary_key=True, max_length=40)
#     session_data = models.TextField()
#     expire_date = models.DateTimeField()

#     class Meta:
#         managed = False
#         db_table = 'django_session'


class ElectricalTransmissionStructures(models.Model):
    objectid = models.AutoField(primary_key=True)
    poleid = models.IntegerField(blank=True, null=True)
    pole_ref = models.CharField(max_length=20, blank=True, null=True)
    csz_wet_pgd = models.SmallIntegerField(blank=True, null=True)
    csz_wet_prob = models.SmallIntegerField(blank=True, null=True)
    csz_dry_pgd = models.SmallIntegerField(blank=True, null=True)
    csz_dry_prob = models.SmallIntegerField(blank=True, null=True)
    phf_wet_pgd = models.SmallIntegerField(blank=True, null=True)
    phf_wet_prob = models.SmallIntegerField(blank=True, null=True)
    phf_dry_pgd = models.SmallIntegerField(blank=True, null=True)
    phf_dry_prob = models.SmallIntegerField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'electrical_transmission_structures'


class Hospital(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=60, blank=True, null=True)
    address = models.CharField(max_length=38, blank=True, null=True)
    city = models.CharField(max_length=20, blank=True, null=True)
    zipcode = models.CharField(max_length=5, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'hospital'


class Hydrants(models.Model):
    objectid = models.AutoField(primary_key=True)
    mainvalvetype = models.CharField(max_length=20, blank=True, null=True)
    hydrantnumber = models.IntegerField(blank=True, null=True)
    active = models.CharField(max_length=3, blank=True, null=True)
    gatecrossstcmnt = models.CharField(max_length=200, blank=True, null=True)
    gatecurbstcmnt = models.CharField(max_length=200, blank=True, null=True)
    controls = models.CharField(max_length=55, blank=True, null=True)
    streetprefix = models.CharField(max_length=2, blank=True, null=True)
    gatecrossstprefix = models.CharField(max_length=2, blank=True, null=True)
    gatecurbstprefix = models.CharField(max_length=2, blank=True, null=True)
    district = models.CharField(max_length=3, blank=True, null=True)
    hydrantcrossstcmnt = models.CharField(max_length=200, blank=True, null=True)
    hydrantcurbstcmnt = models.CharField(max_length=200, blank=True, null=True)
    hydrantcrossstprefix = models.CharField(max_length=2, blank=True, null=True)
    hydrantcurbstprefix = models.CharField(max_length=2, blank=True, null=True)
    hydrantcrossstline = models.CharField(max_length=4, blank=True, null=True)
    hydrantcurbstline = models.CharField(max_length=4, blank=True, null=True)
    hydmaint = models.CharField(max_length=60, blank=True, null=True)
    hydrantmanufacturer = models.CharField(max_length=25, blank=True, null=True)
    hydrantsize = models.FloatField(blank=True, null=True)
    hydrantcrossst = models.CharField(max_length=60, blank=True, null=True)
    hydrantcurbst = models.CharField(max_length=60, blank=True, null=True)
    hydrantcrosssttype = models.CharField(max_length=6, blank=True, null=True)
    hydrantcurbsttype = models.CharField(max_length=6, blank=True, null=True)
    gatecrossstline = models.CharField(max_length=4, blank=True, null=True)
    gatecurbstline = models.CharField(max_length=4, blank=True, null=True)
    gatemanufacturer = models.CharField(max_length=25, blank=True, null=True)
    street = models.CharField(max_length=60, blank=True, null=True)
    gateopens = models.CharField(max_length=3, blank=True, null=True)
    gatecrossst = models.CharField(max_length=60, blank=True, null=True)
    gatecurbst = models.CharField(max_length=60, blank=True, null=True)
    sttype = models.CharField(max_length=6, blank=True, null=True)
    gatecrosssttype = models.CharField(max_length=6, blank=True, null=True)
    gatecurbsttype = models.CharField(max_length=6, blank=True, null=True)
    hydrantstyle = models.CharField(max_length=25, blank=True, null=True)
    watertype = models.CharField(max_length=20, blank=True, null=True)
    waterdistrict = models.CharField(max_length=40, blank=True, null=True)
    facilityid = models.FloatField(blank=True, null=True)
    recorddate = models.DateTimeField(blank=True, null=True)
    locationdetail = models.CharField(max_length=120, blank=True, null=True)
    pressuresource = models.CharField(max_length=120, blank=True, null=True)
    status = models.CharField(max_length=5, blank=True, null=True)
    constructiondate = models.DateTimeField(blank=True, null=True)
    modifiedby = models.CharField(max_length=20, blank=True, null=True)
    modifieddate = models.DateTimeField(blank=True, null=True)
    tempident = models.FloatField(blank=True, null=True)
    synergenid = models.CharField(max_length=17, blank=True, null=True)
    annexationdate = models.DateTimeField(blank=True, null=True)
    annexed = models.CharField(max_length=3, blank=True, null=True)
    comments = models.CharField(max_length=100, blank=True, null=True)
    researched = models.CharField(max_length=3, blank=True, null=True)
    installworkorder = models.CharField(max_length=12, blank=True, null=True)
    removaldate = models.DateTimeField(blank=True, null=True)
    fireonly = models.CharField(max_length=50, blank=True, null=True)
    dataflag = models.CharField(max_length=50, blank=True, null=True)
    manufacturerdate = models.DateTimeField(blank=True, null=True)
    av_oid = models.FloatField(blank=True, null=True)
    facility_folder = models.CharField(max_length=500, blank=True, null=True)
    projectnumber = models.CharField(max_length=20, blank=True, null=True)
    removalproject = models.CharField(max_length=20, blank=True, null=True)
    conditionranking = models.CharField(max_length=1, blank=True, null=True)
    dateconditionranked = models.DateTimeField(blank=True, null=True)
    breakawayinstalled = models.CharField(max_length=3, blank=True, null=True)
    flushingcycle = models.CharField(max_length=3, blank=True, null=True)
    flushed = models.CharField(max_length=3, blank=True, null=True)
    last_flshed = models.DateTimeField(blank=True, null=True)
    flushingreason = models.CharField(max_length=250, blank=True, null=True)
    parentassetid = models.CharField(max_length=15, blank=True, null=True)
    opspecialuse = models.CharField(max_length=3, blank=True, null=True)
    depthofmain = models.IntegerField(blank=True, null=True)
    gatecrossstdistance = models.IntegerField(blank=True, null=True)
    gatecurbstdistance = models.IntegerField(blank=True, null=True)
    hydrantcrossstdist = models.IntegerField(blank=True, null=True)
    hydrantcurbstdist = models.IntegerField(blank=True, null=True)
    gatesize = models.FloatField(blank=True, null=True)
    gatenumberofturns = models.FloatField(blank=True, null=True)
    fittingcode = models.IntegerField(blank=True, null=True)
    rotation = models.FloatField(blank=True, null=True)
    subtype = models.IntegerField(blank=True, null=True)
    quartersection = models.IntegerField(blank=True, null=True)
    owningbusparty = models.IntegerField(blank=True, null=True)
    ancillaryrole = models.IntegerField(blank=True, null=True)
    enabled = models.SmallIntegerField(blank=True, null=True)
    rotation802 = models.FloatField(blank=True, null=True)
    burydepth = models.IntegerField(blank=True, null=True)
    mainsize = models.FloatField(blank=True, null=True)
    parentassetname = models.CharField(max_length=250, blank=True, null=True)
    pwbreferencename = models.CharField(max_length=500, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'hydrants'


class Jurisdictions(models.Model):
    objectid = models.AutoField(primary_key=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    jurisdiction = models.CharField(max_length=100, blank=True, null=True)
    county = models.CharField(max_length=20, blank=True, null=True)
    acres = models.FloatField(blank=True, null=True)
    bldgcount = models.IntegerField(blank=True, null=True)
    bldgsqft = models.IntegerField(blank=True, null=True)
    bldgcost = models.FloatField(blank=True, null=True)
    bldgweight = models.IntegerField(blank=True, null=True)
    contentcost = models.FloatField(blank=True, null=True)
    permresidents = models.IntegerField(blank=True, null=True)
    dayoccupants = models.IntegerField(blank=True, null=True)
    nightoccupants = models.IntegerField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'jurisdictions'


class QuakeLossView(models.Model):
    objectid = models.IntegerField(primary_key=True)
    quake_cd = models.TextField(blank=True, null=True, help_text='csz_m9p0 = Cascadian Subduction Zone quake, phf_m6p8= Portland Hills Fault')
    condition_cd = models.TextField(blank=True, null=True, help_text='wet or dry conditions')
    area_type_cd = models.TextField(blank=True, null=True, help_text='By neighborhood_unit or by jurisdiction')
    jurisdiction = models.CharField(max_length=100, blank=True, null=True)
    nuid = models.IntegerField(blank=True, null=True)
    bldgloss = models.FloatField(blank=True, null=True)
    bldg_lr = models.FloatField(blank=True, null=True)
    contentloss = models.FloatField(blank=True, null=True)
    debris = models.FloatField(blank=True, null=True)
    displacedpop = models.FloatField(blank=True, null=True)
    casdaytotal = models.FloatField(blank=True, null=True)
    casdayl1 = models.FloatField(blank=True, null=True)
    casdayl2 = models.FloatField(blank=True, null=True)
    casdayl3 = models.FloatField(blank=True, null=True)
    casdayl4 = models.FloatField(blank=True, null=True)
    casnighttotal = models.FloatField(blank=True, null=True)
    casnightl1 = models.FloatField(blank=True, null=True)
    casnightl2 = models.FloatField(blank=True, null=True)
    casnightl3 = models.FloatField(blank=True, null=True)
    casnightl4 = models.FloatField(blank=True, null=True)
    pdsnone = models.IntegerField(blank=True, null=True)
    pdsslight = models.IntegerField(blank=True, null=True)
    pdsmoderate = models.IntegerField(blank=True, null=True)
    pdsextensive = models.IntegerField(blank=True, null=True)
    pdscomplete = models.IntegerField(blank=True, null=True)

    class Meta:
#        managed = False
        db_table = 'quake_loss_view'
		

class NeighborhoodUnits(models.Model):
    objectid = models.AutoField(primary_key=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    nuid = models.SmallIntegerField(blank=True, null=True)
    county = models.CharField(max_length=20, blank=True, null=True)
    acres = models.FloatField(blank=True, null=True)
    bldgcount = models.IntegerField(blank=True, null=True)
    bldgsqft = models.IntegerField(blank=True, null=True)
    bldgcost = models.FloatField(blank=True, null=True)
    bldgweight = models.IntegerField(blank=True, null=True)
    contentcost = models.FloatField(blank=True, null=True)
    permresidents = models.IntegerField(blank=True, null=True)
    dayoccupants = models.IntegerField(blank=True, null=True)
    nightoccupants = models.IntegerField(blank=True, null=True)
    wkb_geometry = GeometryField()

    class Meta:
        managed = False
        db_table = 'neighborhood_units'


class OregonLiquefactionSusceptibility(models.Model):
    objectid = models.AutoField(primary_key=True)
    g_mrg_u_l = models.CharField(max_length=60, blank=True, null=True)
    source = models.CharField(max_length=12, blank=True, null=True)
    liq_susc = models.SmallIntegerField(blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'oregon_liquefaction_susceptibility'


class OregonNehrpSiteClass(models.Model):
    objectid = models.AutoField(primary_key=True)
    g_mrg_u_l = models.CharField(max_length=60, blank=True, null=True)
    source = models.CharField(max_length=12, blank=True, null=True)
    nehrp_cl = models.CharField(max_length=2, blank=True, null=True)
    usgs_pnw_vs30 = models.SmallIntegerField(blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'oregon_nehrp_site_class'


class OregonVsMeasurementIntervals(models.Model):
    objectid = models.AutoField(primary_key=True)
    site_id = models.CharField(max_length=15, blank=True, null=True)
    from_m = models.FloatField(blank=True, null=True)
    depth_to_m = models.FloatField(blank=True, null=True)
    vs_m_sec = models.FloatField(blank=True, null=True)
    reptd_lith = models.CharField(max_length=15, blank=True, null=True)
    ogdc_gmrge = models.CharField(max_length=25, blank=True, null=True)
    vsbest = models.CharField(max_length=25, blank=True, null=True)
    vsi_sec = models.FloatField(blank=True, null=True)
    orlamx = models.FloatField(blank=True, null=True)
    orlamy = models.FloatField(blank=True, null=True)
    interval = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'oregon_vs_measurement_intervals'


class OregonVsMeasurementSites(models.Model):
    objectid = models.AutoField(primary_key=True)
    site_id = models.CharField(max_length=15, blank=True, null=True)
    orlam_x = models.FloatField(blank=True, null=True)
    orlam_y = models.FloatField(blank=True, null=True)
    source = models.CharField(max_length=35, blank=True, null=True)
    depth_ft = models.FloatField(blank=True, null=True)
    depth_m = models.FloatField(blank=True, null=True)
    surfunit = models.CharField(max_length=35, blank=True, null=True)
    vs_type = models.CharField(max_length=10, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'oregon_vs_measurement_sites'


class PhfM6P8BedrockGroundmotion(models.Model):
    objectid = models.AutoField(primary_key=True)
    lat = models.FloatField(blank=True, null=True)
    long = models.FloatField(blank=True, null=True)
    pga = models.FloatField(blank=True, null=True)
    pgv = models.FloatField(blank=True, null=True)
    sa03 = models.FloatField(blank=True, null=True)
    sa10 = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'phf_m6p8_bedrock_groundmotion'


class PointsOfService(models.Model):
    objectid = models.AutoField(primary_key=True)
    accountid = models.FloatField(blank=True, null=True)
    addressnumber = models.CharField(max_length=12, blank=True, null=True)
    facilityid = models.FloatField(blank=True, null=True)
    tempuid = models.FloatField(blank=True, null=True)
    commentary = models.CharField(max_length=120, blank=True, null=True)
    modifiedby = models.CharField(max_length=50, blank=True, null=True)
    modifieddate = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=5, blank=True, null=True)
    annexationdate = models.DateTimeField(blank=True, null=True)
    annexed = models.CharField(max_length=3, blank=True, null=True)
    comments = models.CharField(max_length=100, blank=True, null=True)
    researched = models.CharField(max_length=3, blank=True, null=True)
    av_oid = models.FloatField(blank=True, null=True)
    subtype = models.IntegerField(blank=True, null=True)
    enabled = models.SmallIntegerField(blank=True, null=True)
    ancillaryrole = models.SmallIntegerField(blank=True, null=True)
    location_no = models.FloatField(blank=True, null=True)
    parentassetid = models.CharField(max_length=15, blank=True, null=True)
    parentassetname = models.CharField(max_length=250, blank=True, null=True)
    pwbreferencename = models.CharField(max_length=500, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'points_of_service'


class PopulationAndBuildingDensity(models.Model):
    objectid = models.AutoField(primary_key=True)
    bldgcount = models.SmallIntegerField(blank=True, null=True)
    permres = models.FloatField(blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    bldgcount_res = models.SmallIntegerField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'population_and_building_density'


class PressureZones(models.Model):
    objectid = models.AutoField(primary_key=True)
    zoneid = models.FloatField(blank=True, null=True)
    zonehgl = models.IntegerField(blank=True, null=True)
    zonesource = models.CharField(max_length=50, blank=True, null=True)
    zonestreet = models.CharField(max_length=50, blank=True, null=True)
    zonecomments = models.CharField(max_length=200, blank=True, null=True)
    zonename = models.CharField(max_length=120, blank=True, null=True)
    comments = models.CharField(max_length=100, blank=True, null=True)
    deliverymethod = models.CharField(max_length=200, blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'pressure_zones'


class PressurizedMains(models.Model):
    objectid = models.AutoField(primary_key=True)
    depthinches = models.IntegerField(blank=True, null=True)
    pressurerating = models.CharField(max_length=7, blank=True, null=True)
    material = models.CharField(max_length=5, blank=True, null=True)
    exteriorcoating = models.CharField(max_length=5, blank=True, null=True)
    liningtype = models.CharField(max_length=6, blank=True, null=True)
    roughness = models.IntegerField(blank=True, null=True)
    recordedlength = models.IntegerField(blank=True, null=True)
    flowmeasurementid = models.FloatField(blank=True, null=True)
    watertype = models.CharField(max_length=5, blank=True, null=True)
    quartersection = models.IntegerField(blank=True, null=True)
    owningbusparty = models.IntegerField(blank=True, null=True)
    comments = models.CharField(max_length=100, blank=True, null=True)
    locationdetail = models.CharField(max_length=120, blank=True, null=True)
    waterdistrict = models.CharField(max_length=40, blank=True, null=True)
    facilityid = models.FloatField(blank=True, null=True)
    recorddate = models.DateTimeField(blank=True, null=True)
    pressuresource = models.CharField(max_length=120, blank=True, null=True)
    status = models.CharField(max_length=5, blank=True, null=True)
    subtype = models.IntegerField(blank=True, null=True)
    constructiondate = models.DateTimeField(blank=True, null=True)
    modifiedby = models.CharField(max_length=20, blank=True, null=True)
    modifieddate = models.DateTimeField(blank=True, null=True)
    enabled = models.SmallIntegerField(blank=True, null=True)
    mainsize = models.FloatField(blank=True, null=True)
    specialconditions = models.CharField(max_length=40, blank=True, null=True)
    district = models.CharField(max_length=3, blank=True, null=True)
    tempident = models.FloatField(blank=True, null=True)
    fairshare = models.CharField(max_length=50, blank=True, null=True)
    flushdate = models.DateTimeField(blank=True, null=True)
    synergenid = models.CharField(max_length=17, blank=True, null=True)
    annexationdate = models.DateTimeField(blank=True, null=True)
    annexed = models.CharField(max_length=3, blank=True, null=True)
    researched = models.CharField(max_length=3, blank=True, null=True)
    installworkorder = models.CharField(max_length=12, blank=True, null=True)
    removaldate = models.DateTimeField(blank=True, null=True)
    streetname = models.CharField(max_length=250, blank=True, null=True)
    dataflag = models.CharField(max_length=3, blank=True, null=True)
    amid = models.FloatField(blank=True, null=True)
    facility_folder = models.CharField(max_length=500, blank=True, null=True)
    projectnumber = models.CharField(max_length=20, blank=True, null=True)
    removalproject = models.CharField(max_length=20, blank=True, null=True)
    estimatedinstallyear = models.CharField(max_length=4, blank=True, null=True)
    parentassetid = models.CharField(max_length=15, blank=True, null=True)
    parentassetname = models.CharField(max_length=250, blank=True, null=True)
    pwbreferencename = models.CharField(max_length=500, blank=True, null=True)
    cased = models.CharField(max_length=50, blank=True, null=True)
    criticalcrossingtype = models.CharField(max_length=50, blank=True, null=True)
    roadcrossing = models.CharField(max_length=50, blank=True, null=True)
    railcrossing = models.CharField(max_length=250, blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'pressurized_mains'


class RegionalDrinkingWaterAdvisoryBoundary(models.Model):
    objectid = models.AutoField(primary_key=True)
    phoneno = models.CharField(max_length=20, blank=True, null=True)
    display = models.SmallIntegerField(blank=True, null=True)
    analysis = models.SmallIntegerField(blank=True, null=True)
    bullrunyn = models.SmallIntegerField(blank=True, null=True)
    color = models.SmallIntegerField(blank=True, null=True)
    source = models.CharField(max_length=30, blank=True, null=True)
    code = models.SmallIntegerField(blank=True, null=True)
    district = models.CharField(max_length=50, blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'regional_drinking_water_advisory_boundary'


class RegionalWaterDistricts(models.Model):
    objectid_1 = models.AutoField(primary_key=True)
    objectid = models.FloatField(blank=True, null=True)
    phoneno = models.CharField(max_length=20, blank=True, null=True)
    display = models.SmallIntegerField(blank=True, null=True)
    analysis = models.SmallIntegerField(blank=True, null=True)
    bullrunyn = models.SmallIntegerField(blank=True, null=True)
    color = models.SmallIntegerField(blank=True, null=True)
    source = models.CharField(max_length=30, blank=True, null=True)
    code = models.SmallIntegerField(blank=True, null=True)
    district = models.CharField(max_length=50, blank=True, null=True)
    area = models.FloatField(blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    shape_area = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'regional_water_districts'


class Services(models.Model):
    objectid = models.AutoField(primary_key=True)
    accountid = models.FloatField(blank=True, null=True)
    addressnumber = models.CharField(max_length=12, blank=True, null=True)
    alternatenumber = models.CharField(max_length=12, blank=True, null=True)
    streetprefix = models.CharField(max_length=12, blank=True, null=True)
    street = models.CharField(max_length=60, blank=True, null=True)
    streettype = models.CharField(max_length=6, blank=True, null=True)
    multiple = models.CharField(max_length=72, blank=True, null=True)
    addition = models.CharField(max_length=100, blank=True, null=True)
    lot = models.CharField(max_length=30, blank=True, null=True)
    block = models.CharField(max_length=30, blank=True, null=True)
    name = models.CharField(max_length=50, blank=True, null=True)
    propertyid = models.FloatField(blank=True, null=True)
    criticalcustomer = models.CharField(max_length=5, blank=True, null=True)
    permitnumber = models.CharField(max_length=15, blank=True, null=True)
    servicesize = models.FloatField(blank=True, null=True)
    material = models.CharField(max_length=6, blank=True, null=True)
    depthinches = models.IntegerField(blank=True, null=True)
    pavementmaterial = models.CharField(max_length=20, blank=True, null=True)
    ccloc1 = models.CharField(max_length=50, blank=True, null=True)
    ccloc2 = models.CharField(max_length=50, blank=True, null=True)
    curbstopsize = models.FloatField(blank=True, null=True)
    taploc1 = models.CharField(max_length=50, blank=True, null=True)
    taploc2 = models.CharField(max_length=50, blank=True, null=True)
    tapsize = models.FloatField(blank=True, null=True)
    mainsize = models.FloatField(blank=True, null=True)
    mainmaterial = models.CharField(max_length=6, blank=True, null=True)
    quartersection = models.IntegerField(blank=True, null=True)
    status = models.CharField(max_length=5, blank=True, null=True)
    subtype = models.IntegerField(blank=True, null=True)
    facilityid = models.FloatField(blank=True, null=True)
    metersize = models.FloatField(blank=True, null=True)
    metermake = models.CharField(max_length=255, blank=True, null=True)
    meterlocationdetail = models.CharField(max_length=120, blank=True, null=True)
    altlocationdetail = models.CharField(max_length=120, blank=True, null=True)
    serviceindate = models.DateTimeField(blank=True, null=True)
    serviceremvdate = models.DateTimeField(blank=True, null=True)
    comments = models.CharField(max_length=100, blank=True, null=True)
    tempuid = models.FloatField(blank=True, null=True)
    modifiedby = models.CharField(max_length=20, blank=True, null=True)
    modifieddate = models.DateTimeField(blank=True, null=True)
    dimension = models.CharField(max_length=10, blank=True, null=True)
    addnum = models.FloatField(blank=True, null=True)
    servicepointfacilityid = models.FloatField(blank=True, null=True)
    specialconditions = models.CharField(max_length=40, blank=True, null=True)
    flowmeterfacilityid = models.FloatField(blank=True, null=True)
    enabled = models.SmallIntegerField(blank=True, null=True)
    commentary = models.CharField(max_length=250, blank=True, null=True)
    servicebypass = models.CharField(max_length=4, blank=True, null=True)
    synergenid = models.CharField(max_length=17, blank=True, null=True)
    annexationdate = models.DateTimeField(blank=True, null=True)
    annexed = models.CharField(max_length=3, blank=True, null=True)
    researched = models.CharField(max_length=3, blank=True, null=True)
    automatedmeter = models.CharField(max_length=50, blank=True, null=True)
    automatedmetertype = models.CharField(max_length=50, blank=True, null=True)
    installworkorder = models.CharField(max_length=12, blank=True, null=True)
    dataflag = models.CharField(max_length=3, blank=True, null=True)
    av_oid = models.FloatField(blank=True, null=True)
    facility_folder = models.CharField(max_length=500, blank=True, null=True)
    projectnumber = models.CharField(max_length=20, blank=True, null=True)
    removalproject = models.CharField(max_length=20, blank=True, null=True)
    flushingreason = models.CharField(max_length=250, blank=True, null=True)
    flushingcycle = models.CharField(max_length=3, blank=True, null=True)
    location_no = models.FloatField(blank=True, null=True)
    meternumber = models.CharField(max_length=50, blank=True, null=True)
    parentassetid = models.CharField(max_length=15, blank=True, null=True)
    parentassetname = models.CharField(max_length=250, blank=True, null=True)
    pwbreferencename = models.CharField(max_length=500, blank=True, null=True)
    shape_length = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'services'


class SubstationPortland(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    averagexfm = models.DecimalField(max_digits=9, decimal_places=0, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'substation_portland'


class UnreinforcedMasonryBuildings(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    propkey = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    data_sourc = models.CharField(max_length=80, blank=True, null=True)
    demolished = models.CharField(max_length=80, blank=True, null=True)
    upgraded = models.CharField(max_length=80, blank=True, null=True)
    upgrade_da = models.CharField(max_length=80, blank=True, null=True)
    upgrade_st = models.CharField(max_length=80, blank=True, null=True)
    upgrade_pe = models.CharField(max_length=80, blank=True, null=True)
    upgrade_1 = models.CharField(db_column='upgrade__1', max_length=254, blank=True, null=True)  # Field renamed because it contained more than one '_' in a row.
    partial_up = models.CharField(max_length=80, blank=True, null=True)
    phased_sei = models.CharField(max_length=80, blank=True, null=True)
    quarter_se = models.CharField(max_length=80, blank=True, null=True)
    wall_type = models.CharField(max_length=80, blank=True, null=True)
    bldg_use = models.CharField(max_length=80, blank=True, null=True)
    primary_oc = models.CharField(max_length=80, blank=True, null=True)
    occupancy_field = models.CharField(db_column='occupancy_', max_length=80, blank=True, null=True)  # Field renamed because it ended with '_'.
    occupanc_1 = models.CharField(max_length=80, blank=True, null=True)
    occupanc_2 = models.CharField(max_length=80, blank=True, null=True)
    num_people = models.CharField(max_length=80, blank=True, null=True)
    num_storie = models.CharField(max_length=80, blank=True, null=True)
    floor_sq_f = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    year_built = models.CharField(max_length=80, blank=True, null=True)
    vacant = models.CharField(max_length=80, blank=True, null=True)
    reviewed_d = models.CharField(max_length=80, blank=True, null=True)
    verified_d = models.CharField(max_length=80, blank=True, null=True)
    liquefacti = models.CharField(max_length=80, blank=True, null=True)
    property_c = models.CharField(max_length=80, blank=True, null=True)
    units = models.CharField(max_length=80, blank=True, null=True)
    demo_permi = models.CharField(max_length=80, blank=True, null=True)
    bldg_name = models.CharField(max_length=113, blank=True, null=True)
    city_owned = models.CharField(max_length=80, blank=True, null=True)
    bps_bldg_i = models.CharField(max_length=80, blank=True, null=True)
    address = models.CharField(max_length=80, blank=True, null=True)
    urm_class = models.CharField(max_length=80, blank=True, null=True)
    city_finan = models.CharField(max_length=80, blank=True, null=True)
    city_inter = models.CharField(max_length=80, blank=True, null=True)
    historic_b = models.CharField(max_length=80, blank=True, null=True)
    hri_rank = models.CharField(max_length=80, blank=True, null=True)
    hri_name = models.CharField(max_length=80, blank=True, null=True)
    conservati = models.CharField(max_length=80, blank=True, null=True)
    historic_d = models.CharField(max_length=80, blank=True, null=True)
    local_land = models.CharField(max_length=80, blank=True, null=True)
    conserva_1 = models.CharField(max_length=80, blank=True, null=True)
    contributi = models.CharField(max_length=80, blank=True, null=True)
    national_l = models.CharField(max_length=80, blank=True, null=True)
    historic_s = models.CharField(max_length=80, blank=True, null=True)
    shapestare = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    shapestlen = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'unreinforced_masonry_buildings'

class Address(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    address_id = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    add_num = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    add_num_ch = models.CharField(max_length=80, blank=True, null=True)
    leading_ze = models.CharField(max_length=80, blank=True, null=True)
    str_predir = models.CharField(max_length=80, blank=True, null=True)
    str_name = models.CharField(max_length=80, blank=True, null=True)
    str_type_c = models.CharField(max_length=80, blank=True, null=True)
    str_postdi = models.CharField(max_length=80, blank=True, null=True)
    str_nm_ful = models.CharField(max_length=80, blank=True, null=True)
    unit_value = models.CharField(max_length=80, blank=True, null=True)
    add_full = models.CharField(max_length=80, blank=True, null=True)
    city = models.CharField(max_length=80, blank=True, null=True)
    state = models.CharField(max_length=80, blank=True, null=True)
    state_abbr = models.CharField(max_length=80, blank=True, null=True)
    zip_code = models.CharField(max_length=80, blank=True, null=True)
    zip4 = models.CharField(max_length=80, blank=True, null=True)
    juris = models.CharField(max_length=80, blank=True, null=True)
    county = models.CharField(max_length=80, blank=True, null=True)
    status_mar = models.CharField(max_length=80, blank=True, null=True)
    state_id = models.CharField(max_length=80, blank=True, null=True)
    tlid = models.CharField(max_length=80, blank=True, null=True)
    source = models.CharField(max_length=80, blank=True, null=True)
    x = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    y = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'address'

class FireSta(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    station = models.CharField(max_length=6, blank=True, null=True)
    address = models.CharField(max_length=38, blank=True, null=True)
    city = models.CharField(max_length=28, blank=True, null=True)
    district = models.CharField(max_length=40, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'fire_sta'

class BasicEarthquakeEmergencyCommunicationNodeBeecnLocations(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    hub_name = models.CharField(max_length=80, blank=True, null=True)
    site_name = models.CharField(max_length=80, blank=True, null=True)
    location = models.CharField(max_length=80, blank=True, null=True)
    site_owner = models.CharField(max_length=80, blank=True, null=True)
    x_coord = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    y_coord = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    map_id = models.CharField(max_length=80, blank=True, null=True)
    barrier_id = models.CharField(max_length=80, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'basic_earthquake_emergency_communication_node_beecn_locations'


class MajorRiverBridges(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    objectid_1 = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    name = models.CharField(max_length=80, blank=True, null=True)
    paved = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    shape_leng = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    shape_area = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    shape_le_1 = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'major_river_bridges'


class NeighborhoodsRegions(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    objectid = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    name = models.CharField(max_length=80, blank=True, null=True)
    commplan = models.CharField(max_length=80, blank=True, null=True)
    shared = models.CharField(max_length=80, blank=True, null=True)
    coalit = models.CharField(max_length=80, blank=True, null=True)
    horz_vert = models.CharField(max_length=80, blank=True, null=True)
    maplabel = models.CharField(max_length=80, blank=True, null=True)
    id = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    shape_leng = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    shape_area = models.DecimalField(max_digits=24, decimal_places=15, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'neighborhoods_regions'


class Schools(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    school_id = models.DecimalField(max_digits=5, decimal_places=0, blank=True, null=True)
    schinstid = models.DecimalField(max_digits=5, decimal_places=0, blank=True, null=True)
    distinstid = models.DecimalField(max_digits=5, decimal_places=0, blank=True, null=True)
    ncesschid = models.DecimalField(max_digits=12, decimal_places=0, blank=True, null=True)
    ncesdistid = models.DecimalField(max_digits=7, decimal_places=0, blank=True, null=True)
    site_id = models.DecimalField(max_digits=5, decimal_places=0, blank=True, null=True)
    primaryuse = models.DecimalField(max_digits=3, decimal_places=0, blank=True, null=True)
    name = models.CharField(max_length=60, blank=True, null=True)
    address = models.CharField(max_length=50, blank=True, null=True)
    address2 = models.CharField(max_length=50, blank=True, null=True)
    city = models.CharField(max_length=30, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zipcode = models.CharField(max_length=5, blank=True, null=True)
    zip4 = models.CharField(max_length=4, blank=True, null=True)
    phone = models.CharField(max_length=12, blank=True, null=True)
    level_no = models.DecimalField(max_digits=3, decimal_places=0, blank=True, null=True)
    level_name = models.CharField(max_length=30, blank=True, null=True)
    dist_no = models.CharField(max_length=10, blank=True, null=True)
    district = models.CharField(max_length=30, blank=True, null=True)
    grade = models.CharField(max_length=8, blank=True, null=True)
    type = models.CharField(max_length=7, blank=True, null=True)
    county = models.CharField(max_length=30, blank=True, null=True)
    updatedate = models.DateField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'schools'

class RlisSt180520(models.Model):
    ogc_fid = models.AutoField(primary_key=True)
    fid = models.BigIntegerField(blank=True, null=True)
    name = models.CharField(max_length=100, blank=True, null=True)
    area = models.FloatField(blank=True, null=True)
    sqmile = models.FloatField(blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'rlis_st_180520'


class POI(models.Model):
    pk_id = models.CharField(max_length=255, primary_key=True)
    ogc_fid = models.DecimalField(max_digits=5, decimal_places=0, blank=True, null=True)
    type = models.CharField(max_length=20, blank=True, null=True)
    description_txt = models.CharField(max_length=255, blank=True, null=True)
    description2_txt = models.CharField(max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=255, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zipcode = models.CharField(max_length=5, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'POI_view'


class DisasterNeighborhoods(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    wkb_geometry = models.TextField(blank=True, null=True)  # This field type is a guess.
    pgv_site_count = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_max = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min_mmi = models.BigIntegerField(blank=True, null=True)
    pgv_site_max_mmi = models.BigIntegerField(blank=True, null=True)
    pgv_site_mean_mmi = models.BigIntegerField(blank=True, null=True)
    pgd_landslide_dry_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'disaster_neighborhoods'


class DisasterNeighborhoodView(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    wkb_geometry = GeometryField()
    pgv_site_count = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_max = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min_mmi = models.IntegerField(blank=True, null=True)
    pgv_site_max_mmi = models.IntegerField(blank=True, null=True)
    pgv_site_mean_mmi = models.IntegerField(blank=True, null=True)
    pgd_landslide_dry_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min_mmi_txt = models.TextField(blank=True, null=True)
    pgv_site_max_mmi_txt = models.TextField(blank=True, null=True)
    pgv_site_min_mmi_txt = models.TextField(blank=True, null=True)
    pgv_site_min_desc = models.TextField(blank=True, null=True)
    pgv_site_max_mmi_txt = models.TextField(blank=True, null=True)
    pgv_site_max_desc = models.TextField(blank=True, null=True)
    pgv_site_mean_mmi_txt = models.TextField(blank=True, null=True)
    pgv_site_mean_desc = models.TextField(blank=True, null=True)
    census_response_rate = models.CharField(max_length=255, blank=True, null=True)
    quadrant = models.CharField(max_length=255, blank=True, null=True)
    acres = models.CharField(max_length=255, blank=True, null=True)
    buildingcount = models.CharField(max_length=255, blank=True, null=True)
    buildingsquarefeet = models.CharField(max_length=255, blank=True, null=True)
    buildingcost = models.CharField(max_length=255, blank=True, null=True)
    buildingweight = models.CharField(max_length=255, blank=True, null=True)
    contentcost = models.CharField(max_length=255, blank=True, null=True)
    permanentresidents = models.CharField(max_length=255, blank=True, null=True)
    dayoccupants = models.CharField(max_length=255, blank=True, null=True)
    nightoccupants = models.CharField(max_length=255, blank=True, null=True)
    total_population = models.CharField(max_length=255, blank=True, null=True)
    scenario_cd = models.CharField(max_length=10, blank=True, null=True)
    buildingloss = models.CharField(max_length=255, blank=True, null=True)
    contentloss = models.CharField(max_length=255, blank=True, null=True)
    debris = models.CharField(max_length=255, blank=True, null=True)
    displacedpopulation = models.CharField(max_length=255, blank=True, null=True)
    buildings_nodamage = models.CharField(max_length=255, blank=True, null=True)
    buildings_slightdamage = models.CharField(max_length=255, blank=True, null=True)
    buildings_moderatedamage = models.CharField(max_length=255, blank=True, null=True)
    buildings_extensivedamage = models.CharField(max_length=255, blank=True, null=True)
    buildings_completedamage = models.CharField(max_length=255, blank=True, null=True)
    casualtiestotal_day = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel1_day = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel2_day = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel3_day = models.CharField(max_length=255, blank=True, null=True)
    fatalitiestotal_day = models.CharField(max_length=255, blank=True, null=True)
    casualtiestotal_night = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel1_night = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel2_night = models.CharField(max_length=255, blank=True, null=True)
    casualtieslevel3_night = models.CharField(max_length=255, blank=True, null=True)
    fatalitiestotal_night = models.CharField(max_length=255, blank=True, null=True)
    injuriestotal_day = models.CharField(max_length=255, blank=True, null=True)
    injuriestotal_night = models.CharField(max_length=255, blank=True, null=True)
    displaced_percap = models.CharField(max_length=255, blank=True, null=True)
    ngeo_json = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'disaster_neighborhood_view'

class DisasterNeighborhoodGrid(models.Model):
    id = models.IntegerField(primary_key=True)
    centroidx = models.CharField(max_length=255, blank=True, null=True)
    centroidy = models.CharField(max_length=255, blank=True, null=True)
    x_simple = models.CharField(max_length=255, blank=True, null=True)
    y_simple = models.CharField(max_length=255, blank=True, null=True)
    wkb_geometry = GeometryField()
    pgv_site_count = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_max = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_count = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_std = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean = models.CharField(max_length=255, blank=True, null=True)
    pgv_site_min_mmi = models.IntegerField(blank=True, null=True)
    pgv_site_max_mmi = models.IntegerField(blank=True, null=True)
    pgv_site_mean_mmi = models.IntegerField(blank=True, null=True)
    pgd_landslide_dry_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_dry_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_landslide_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_min_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_max_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_liquefaction_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)
    pgd_total_wet_mean_di = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'disaster_neighborhood_grid'
