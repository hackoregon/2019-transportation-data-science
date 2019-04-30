from django.db import models

# Create your models here.
class Song(models.Model):
    id = models.IntegerField(primary_key=True)
    release_date = models.DateTimeField()
    title = models.CharField(max_length=100, blank=True, default='')
    album = models.TextField()
    writer = models.TextField()

    class Meta:
        managed = False
        db_table = 'api_song'
        ordering = ('release_date',)
