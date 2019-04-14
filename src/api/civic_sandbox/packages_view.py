from django.http import JsonResponse
from civic_sandbox import packages

def packages_view(request):
    return JsonResponse(packages.package_info)