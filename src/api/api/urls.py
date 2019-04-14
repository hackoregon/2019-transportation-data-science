from django.contrib import admin
from django.urls import path, include
from django.conf.urls import url
from rest_framework import routers

from api import views

router = routers.DefaultRouter()
router.register(r'NeighborhoodUnits', views.NeighborhoodUnitsSet)
router.register(r'BuildingFootprints', views.BuildingFootprintsSet)
router.register(r'ElectricalTransmissionStructures', views.ElectricalTransmissionStructuresSet)
router.register(r'Jurisdictions', views.JurisdictionsSet)
router.register(r'QuakeLossView', views.QuakeLossViewSet)
router.register(r'PhfM6P8BedrockGroundmotion', views.PhfM6P8BedrockGroundmotionSet)
router.register(r'PopulationAndBuildingDensity', views.PopulationAndBuildingDensitySet)
router.register(r'CensusBgAoi', views.CensusBgAoiSet)
router.register(r'CommunityCenters', views.CommunityCentersSet)
router.register(r'Hospital', views.HospitalSet)
router.register(r'OregonLiquefactionSusceptibility', views.OregonLiquefactionSusceptibilitySet)
router.register(r'OregonNehrpSiteClass', views.OregonNehrpSiteClassSet)
router.register(r'OregonVsMeasurementIntervals', views.OregonVsMeasurementIntervalsSet)
router.register(r'OregonVsMeasurementSites', views.OregonVsMeasurementSitesSet)
router.register(r'UnreinforcedMasonryBuildings', views.UnreinforcedMasonryBuildingsSet)
router.register(r'Address', views.AddressSet)
router.register(r'FireSta', views.FireStaSet)
router.register(r'Schools', views.SchoolsSet)
router.register(r'NeighborhoodsRegions', views.NeighborhoodsRegionsSet)
router.register(r'MajorRiverBridges', views.MajorRiverBridgesSet)
router.register(r'BasicEarthquakeEmergencyCommunicationNodeBeecnLocations', views.BasicEarthquakeEmergencyCommunicationNodeBeecnLocationsSet)
router.register(r'RlisSt180520', views.RlisSt180520Set)
router.register(r'POI', views.POISet)
router.register(r'DisasterNeighborhoods', views.DisasterNeighborhoodsSet)
router.register(r'DisasterNeighborhoodView', views.DisasterNeighborhoodViewSet)
router.register(r'DisasterNeighborhoodGrid', views.DisasterNeighborhoodGridSet)
#router.register(r'Hydrants', views.HydrantsSet)
#router.register(r'PointsOfService', views.PointsOfServiceSet)
#router.register(r'PressureZones', views.PressureZonesSet)
#router.register(r'PressurizedMains', views.PressurizedMainsSet)
#router.register(r'RegionalDrinkingWaterAdvisoryBoundary', views.RegionalDrinkingWaterAdvisoryBoundarySet)
#router.register(r'RegionalWaterDistricts', views.RegionalWaterDistrictsSet)
#router.register(r'CountiesAoi', views.CountiesAoiSet)
#router.register(r'SubstationPortland', views.SubstationPortlandSet)
#router.register(r'Services', views.ServicesSet)

urlpatterns = [
    path('', include(router.urls)),
]
