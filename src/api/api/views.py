from django.shortcuts import render
from rest_framework import viewsets
from django.http import JsonResponse, HttpResponseServerError, HttpResponse

from api.models import preexisting_models
from api import serializers


class NeighborhoodUnitsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows NeighborhoodUnits to be viewed or listed.
    """
    queryset = preexisting_models.NeighborhoodUnits.objects.all()
    serializer_class = serializers.NeighborhoodUnitsSerializer


class BuildingFootprintsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows BuildingFootprintsSet to be viewed or listed.
    """
    queryset = preexisting_models.BuildingFootprints.objects.all()
    serializer_class = serializers.BuildingFootprintsSerializer


class ElectricalTransmissionStructuresSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows ElectricalTransmissionStructuresSet to be viewed or listed.
    """
    queryset = preexisting_models.ElectricalTransmissionStructures.objects.all()
    serializer_class = serializers.ElectricalTransmissionStructuresSerializer
    

class HydrantsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows HydrantsSet to be viewed or listed.
    """
    queryset = preexisting_models.Hydrants.objects.all()
    serializer_class = serializers.HydrantsSerializer


class JurisdictionsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows JurisdictionsSet to be viewed or listed.
    """
    queryset = preexisting_models.Jurisdictions.objects.all()
    serializer_class = serializers.JurisdictionsSerializer


class QuakeLossViewSet(viewsets.ReadOnlyModelViewSet):
    """
    DOGAMI 2018 data indicating quake damages depending on 
	the type of quake (CSZ or PHF) and dry or wet conditions.
	The data can be viewed by Jurisdiction or Portland Neighborhood
    """
    queryset = preexisting_models.QuakeLossView.objects.all()
    serializer_class = serializers.QuakeLossViewSerializer


class PhfM6P8BedrockGroundmotionSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows PhfM6P8BedrockGroundmotionSet to be viewed or listed.
    """
    queryset = preexisting_models.PhfM6P8BedrockGroundmotion.objects.all()
    serializer_class = serializers.PhfM6P8BedrockGroundmotionSerializer


class PointsOfServiceSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows PointsOfServiceSet to be viewed or listed.
    """
    queryset = preexisting_models.PointsOfService.objects.all()
    serializer_class = serializers.PointsOfServiceSerializer


class PopulationAndBuildingDensitySet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows PopulationAndBuildingDensitySet to be viewed or listed.
    """
    queryset = preexisting_models.PopulationAndBuildingDensity.objects.all()
    serializer_class = serializers.PopulationAndBuildingDensitySerializer


class PressureZonesSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows PressureZonesSet to be viewed or listed.
    """
    queryset = preexisting_models.PressureZones.objects.all()
    serializer_class = serializers.PressureZonesSerializer


class PressurizedMainsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows PressurizedMainsSet to be viewed or listed.
    """
    queryset = preexisting_models.PressurizedMains.objects.all()
    serializer_class = serializers.PressurizedMainsSerializer


class RegionalDrinkingWaterAdvisoryBoundarySet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows RegionalDrinkingWaterAdvisoryBoundarySet to be viewed or listed.
    """
    queryset = preexisting_models.RegionalDrinkingWaterAdvisoryBoundary.objects.all()
    serializer_class = serializers.RegionalDrinkingWaterAdvisoryBoundarySerializer


class RegionalWaterDistrictsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows RegionalWaterDistrictsSet to be viewed or listed.
    """
    queryset = preexisting_models.RegionalWaterDistricts.objects.all()
    serializer_class = serializers.RegionalWaterDistrictsSerializer


class ServicesSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows ServicesSet to be viewed or listed.
    """
    queryset = preexisting_models.Services.objects.all()
    serializer_class = serializers.ServicesSerializer

class UnreinforcedMasonryBuildingsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows UnreinforcedMasonryBuildingsSet to be viewed or listed.
    """
    queryset = preexisting_models.UnreinforcedMasonryBuildings.objects.all()
    serializer_class = serializers.UnreinforcedMasonryBuildingsSerializer

class SubstationPortlandSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows SubstationPortlandSet to be viewed or listed.
    """
    queryset = preexisting_models.SubstationPortland.objects.all()
    serializer_class = serializers.SubstationPortlandSerializer

class OregonVsMeasurementSitesSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows OregonVsMeasurementSitesSet to be viewed or listed.
    """
    queryset = preexisting_models.OregonVsMeasurementSites.objects.all()
    serializer_class = serializers.OregonVsMeasurementSitesSerializer

class OregonVsMeasurementIntervalsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows OregonVsMeasurementIntervalsSet to be viewed or listed.
    """
    queryset = preexisting_models.OregonVsMeasurementIntervals.objects.all()
    serializer_class = serializers.OregonVsMeasurementIntervalsSerializer

class OregonNehrpSiteClassSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows OregonNehrpSiteClassSet to be viewed or listed.
    """
    queryset = preexisting_models.OregonNehrpSiteClass.objects.all()
    serializer_class = serializers.OregonNehrpSiteClassSerializer

class OregonLiquefactionSusceptibilitySet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows OregonLiquefactionSusceptibilitySet to be viewed or listed.
    """
    queryset = preexisting_models.OregonLiquefactionSusceptibility.objects.all()
    serializer_class = serializers.OregonLiquefactionSusceptibilitySerializer

class HospitalSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows HospitalSet to be viewed or listed.
    """
    queryset = preexisting_models.Hospital.objects.all()
    serializer_class = serializers.HospitalSerializer

class CountiesAoiSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows CountiesAoiSet to be viewed or listed.
    """
    queryset = preexisting_models.CountiesAoi.objects.all()
    serializer_class = serializers.CountiesAoiSerializer

class CommunityCentersSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows CommunityCentersSet to be viewed or listed.
    """
    queryset = preexisting_models.CommunityCenters.objects.all()
    serializer_class = serializers.CommunityCentersSerializer

class CensusBgAoiSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows CensusBgAoiSet to be viewed or listed.
    """
    queryset = preexisting_models.CensusBgAoi.objects.all()
    serializer_class = serializers.CensusBgAoiSerializer
	
class AddressSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows AddressSet to be viewed or listed.
    """
    queryset = preexisting_models.Address.objects.all()
    serializer_class = serializers.AddressSerializer

class FireStaSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows FireStations to be viewed or listed.
    """
    queryset = preexisting_models.FireSta.objects.all()
    serializer_class = serializers.FireStaSerializer
	
class SchoolsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows Schools to be viewed or listed.
    """
    queryset = preexisting_models.Schools.objects.all()
    serializer_class = serializers.SchoolsSerializer

class NeighborhoodsRegionsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows NeighborhoodsRegions to be viewed or listed.
    """
    queryset = preexisting_models.NeighborhoodsRegions.objects.all()
    serializer_class = serializers.NeighborhoodsRegionsSerializer

class MajorRiverBridgesSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows MajorRiverBridges to be viewed or listed.
    """
    queryset = preexisting_models.MajorRiverBridges.objects.all()
    serializer_class = serializers.MajorRiverBridgesSerializer

class BasicEarthquakeEmergencyCommunicationNodeBeecnLocationsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows BEECNs (BasicEarthquake Emergency Communication Nodes) to be viewed or listed.
    """
    queryset = preexisting_models.BasicEarthquakeEmergencyCommunicationNodeBeecnLocations.objects.all()
    serializer_class = serializers.BasicEarthquakeEmergencyCommunicationNodeBeecnLocationsSerializer

class RlisSt180520Set(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that allows RLIS neighborhood regions to be viewed or listed.
    """
    queryset = preexisting_models.RlisSt180520.objects.all()
    serializer_class = serializers.RlisSt180520Serializer


class POISet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that shows points of interest (Hospitals, schools, BEECN sites, etc)
    """
    queryset = preexisting_models.POI.objects.all()
    serializer_class = serializers.POISerializer

class DisasterNeighborhoodsSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that shows disaster information per neighborhood
    """
    queryset = preexisting_models.DisasterNeighborhoods.objects.all()
    serializer_class = serializers.DisasterNeighborhoodsSerializer

class DisasterNeighborhoodViewSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that shows disaster information per neighborhood
    """
    queryset = preexisting_models.DisasterNeighborhoodView.objects.all()
    serializer_class = serializers.DisasterNeighborhoodViewSerializer

class DisasterNeighborhoodGridSet(viewsets.ReadOnlyModelViewSet):
    """
    API endpoint that shows calculated stats per neighborhood grid
    """
    queryset = preexisting_models.DisasterNeighborhoodGrid.objects.all()
    serializer_class = serializers.DisasterNeighborhoodGridSerializer

    # disable automatic schema generation:
    # (https://www.django-rest-framework.org/community/3.7-announcement/#customizing-api-docs-schema-generation)
    #schema = None

    def get_queryset(self):
        latitude = float(self.request.GET.get('lat'))
        longitude = float(self.request.GET.get('long'))

        increment = 0.002
        rounded_lat = round(latitude/increment)*increment
        rounded_long = round(longitude/increment)*increment

        qs = preexisting_models.DisasterNeighborhoodGrid.objects.filter(x_simple=rounded_long)
        qs = qs.filter(y_simple=rounded_lat)
        return qs