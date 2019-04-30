from rest_framework import serializers
from api.models import Song

class SongSerializer(serializers.ModelSerializer):
    class Meta:
        model = Song
        fields = ('id', 'title', 'release_date', 'album', 'writer')
