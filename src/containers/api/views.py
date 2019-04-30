from django.http import HttpResponse, JsonResponse
from rest_framework.decorators import api_view, detail_route
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from api.models import Song
from api.serializers import SongSerializer
from rest_framework import generics
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.reverse import reverse
from rest_framework import renderers
from rest_framework import viewsets
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend, FilterSet

class SongViewSet(viewsets.ModelViewSet):

    queryset = Song.objects.all()
    serializer_class = SongSerializer
    filter_backends = (SearchFilter,DjangoFilterBackend,OrderingFilter,)
    search_fields = '__all__'
    filter_fields = '__all__'
    ordering_fields = '__all__'
#
#
# def song_list(request):
#     """
#     List all songs, or create a new song.
#     """
#     if request.method == 'GET':
#         songs = Song.objects.all()
#         serializer = SongSerializer(songs, many=True)
#         return JsonResponse(serializer.data, safe=False)
#
#     elif request.method == 'POST':
#         data = JSONParser().parse(request)
#         serializer = SongSerializer(data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return JsonResponse(serializer.data, status=201)
#         return JsonResponse(serializer.errors, status=400)
#
# def song_detail(request, pk):
#     """
#     Retrieve, update or delete a code snippet.
#     """
#     try:
#         song = Song.objects.get(pk=pk)
#     except Song.DoesNotExist:
#         return HttpResponse(status=404)
#
#     if request.method == 'GET':
#         serializer = SongSerializer(song)
#         return JsonResponse(serializer.data)
#
#     elif request.method == 'PUT':
#         data = JSONParser().parse(request)
#         serializer = SongSerializer(song, data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return JsonResponse(serializer.data)
#         return JsonResponse(serializer.errors, status=400)
#
#     elif request.method == 'DELETE':
#         song.delete()
#         return HttpResponse(status=204)
