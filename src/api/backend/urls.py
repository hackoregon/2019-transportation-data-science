"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework_swagger.views import get_swagger_view
from rest_framework.documentation import include_docs_urls
from backend import settings

import api

swagger_docs_title = 'Disaster Resilience API'

# schema view
schema_view = get_swagger_view(title=swagger_docs_title)

urlpatterns = [
    path('disaster-resilience/', schema_view),
    path('disaster-resilience/api/', include('api.urls')),
    path('disaster-resilience/docs/', include_docs_urls(title=swagger_docs_title)),
    path('disaster-resilience/sandbox/', include('civic_sandbox.urls')),
]

if settings.ENABLE_ADMIN_INTERFACE:    
       urlpatterns.append(path('admin/', admin.site.urls))