from django.conf.urls import url
from django.urls import include
from rest_framework.urlpatterns import format_suffix_patterns
from civic_sandbox import views
from civic_sandbox import packages_view


urlpatterns = [
    url(r'^slides/poi/', views.poi),
    url(r'^foundations/shaking/', views.shaking),
    url(r'^foundations/liquefaction/', views.liquefaction),
    url(r'^foundations/landslide/', views.landslide),
    url(r'^foundations/censusresponse/', views.censusresponse),
    url(r'^package_info/', packages_view.packages_view, name='package_info'),
    ]

urlpatterns = format_suffix_patterns(urlpatterns)
