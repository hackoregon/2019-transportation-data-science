from rest_framework import serializers
from rest_framework_gis.serializers import GeoFeatureModelSerializer

from api import preexisting_models


class NeighborhoodUnitsSerializer(GeoFeatureModelSerializer):
    class Meta:
        model = preexisting_models.NeighborhoodUnits
        fields = '__all__'
        geo_field = 'wkb_geometry'

class BuildingFootprintsSerializer(GeoFeatureModelSerializer):
    class Meta:
        model = preexisting_models.BuildingFootprints 
        fields = '__all__'
        geo_field = 'wkb_geometry'

class CensusBgAoiSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.CensusBgAoi
        fields = '__all__'

class CommunityCentersSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.CommunityCenters
        fields = '__all__'

class CountiesAoiSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.CountiesAoi
        fields = '__all__'

class HospitalSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Hospital
        fields = '__all__'

class OregonLiquefactionSusceptibilitySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.OregonLiquefactionSusceptibility
        fields = '__all__'

class OregonNehrpSiteClassSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.OregonNehrpSiteClass
        fields = '__all__'

class OregonVsMeasurementIntervalsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.OregonVsMeasurementIntervals
        fields = '__all__'

class OregonVsMeasurementSitesSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.OregonVsMeasurementSites
        fields = '__all__'

class SubstationPortlandSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.SubstationPortland
        fields = '__all__'

class UnreinforcedMasonryBuildingsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.UnreinforcedMasonryBuildings
        fields = '__all__'

class ElectricalTransmissionStructuresSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.ElectricalTransmissionStructures
        fields = '__all__'

class HydrantsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Hydrants
        fields = '__all__'

class JurisdictionsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Jurisdictions
        fields = '__all__'

class QuakeLossViewSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.QuakeLossView
        fields = '__all__'

class PhfM6P8BedrockGroundmotionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.PhfM6P8BedrockGroundmotion
        fields = '__all__'

class PointsOfServiceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.PointsOfService
        fields = '__all__'

class PopulationAndBuildingDensitySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.PopulationAndBuildingDensity
        fields = '__all__'

class PressureZonesSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.PressureZones
        fields = '__all__'

class PressurizedMainsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.PressurizedMains
        fields = '__all__'

class RegionalDrinkingWaterAdvisoryBoundarySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.RegionalDrinkingWaterAdvisoryBoundary
        fields = '__all__'

class RegionalWaterDistrictsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.RegionalWaterDistricts
        fields = '__all__'

class ServicesSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Services
        fields = '__all__'

class AddressSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Address
        fields = '__all__'

class FireStaSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.FireSta
        fields = '__all__'

		
class SchoolsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.Schools
        fields = '__all__'


class NeighborhoodsRegionsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.NeighborhoodsRegions
        fields = '__all__'


class MajorRiverBridgesSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.MajorRiverBridges
        fields = '__all__'


class BasicEarthquakeEmergencyCommunicationNodeBeecnLocationsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.BasicEarthquakeEmergencyCommunicationNodeBeecnLocations
        fields = '__all__'

class RlisSt180520Serializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.RlisSt180520
        fields = '__all__'

class POISerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.POI
        fields = '__all__'

class DisasterNeighborhoodsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = preexisting_models.DisasterNeighborhoods
        fields = '__all__'

class DisasterNeighborhoodViewSerializer(GeoFeatureModelSerializer):
    class Meta:
        model = preexisting_models.DisasterNeighborhoodView
        fields = '__all__'
        geo_field = 'wkb_geometry'

class DisasterNeighborhoodGridSerializer(GeoFeatureModelSerializer):
    class Meta:
        model = preexisting_models.DisasterNeighborhoodGrid
        fields = '__all__'
        geo_field = 'wkb_geometry'