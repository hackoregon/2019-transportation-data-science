from django.test import TestCase, SimpleTestCase, TransactionTestCase
from api.models import preexisting_models
from rest_framework.test import APIClient
from rest_framework import status

# Django, Writing and Running Unit Tests: https://docs.djangoproject.com/en/2.0/topics/testing/overview/
# Django, Automated Unit Testing Tutorial: https://docs.djangoproject.com/en/2.0/intro/tutorial05/

class RootEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_list_response(self):
        response = self.client.get('/disaster-resilience/')
        assert response.status_code == status.HTTP_200_OK

class APIRootEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_response(self):
        response = self.client.get('/disaster-resilience/api/')
        assert response.status_code == status.HTTP_200_OK

class DocsEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_response(self):
        response = self.client.get('/disaster-resilience/docs/')
        assert response.status_code == status.HTTP_200_OK

class SandboxAPIEndpointsTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.datasets = ['foundations/censusresponse','foundations/landslide/','foundations/liquefaction','foundations/shaking','slides/poi/']
    def test_list_responses(self):
        for endpoint in self.datasets:
            response = self.client.get('/disaster-resilience/sandbox/'+endpoint+'/')
            assert response.status_code == status.HTTP_200_OK
    def test_detail_responses(self):
        for endpoint in self.datasets:
            response = self.client.get('/disaster-resilience/sandbox/'+endpoint+"/1/")
            assert response.status_code == status.HTTP_200_OK

class APIEndpointsTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.datasets = ['NeighborhoodUnits', 'BuildingFootprints', 'ElectricalTransmissionStructures', 'Jurisdictions', 'PhfM6P8BedrockGroundmotion', 'PopulationAndBuildingDensity', 'CensusBgAoi', 'CommunityCenters', 'Hospital', 'OregonLiquefactionSusceptibility', 'OregonNehrpSiteClass', 'OregonVsMeasurementIntervals', 'OregonVsMeasurementSites', 'UnreinforcedMasonryBuildings', 'Address', 'FireSta', 'Schools', 'NeighborhoodsRegions', 'MajorRiverBridges', 'BasicEarthquakeEmergencyCommunicationNodeBeecnLocations', 'RlisSt180520', 'DisasterNeighborhoods', 'DisasterNeighborhoodView']
    def test_list_responses(self):
        for endpoint in self.datasets:
            response = self.client.get('/disaster-resilience/api/'+endpoint+'/')
            assert response.status_code == status.HTTP_200_OK
    def test_detail_responses(self):
        for endpoint in self.datasets:
            response = self.client.get('/disaster-resilience/api/'+endpoint+'/1/')
            assert response.status_code == status.HTTP_200_OK
        
class QuakeLossViewEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_list_response(self):
        response = self.client.get('/disaster-resilience/api/QuakeLossView/')
        assert response.status_code == status.HTTP_200_OK
    def test_detail_response(self):
        response = self.client.get('/disaster-resilience/api/QuakeLossView/2525/')
        assert response.status_code == status.HTTP_200_OK

class DisasterNeighborhoodGridEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_CENTRL_office_response(self):
        response = self.client.get('/disaster-resilience/api/DisasterNeighborhoodGrid/?lat=45.523628&long=-122.656646')
        assert response.status_code == status.HTTP_200_OK
    def test_rounding_response(self):
        response = self.client.get('/disaster-resilience/api/DisasterNeighborhoodGrid/?lat=45.592&long=-122.835')
        assert response.status_code == status.HTTP_200_OK

class POIEndpointTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
    def test_list_response(self):
        response = self.client.get('/disaster-resilience/api/POI/')
        assert response.status_code == status.HTTP_200_OK
    def test_detail_response(self):
        response = self.client.get('/disaster-resilience/api/POI/BEECN1/')
        assert response.status_code == status.HTTP_200_OK