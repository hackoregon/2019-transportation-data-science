packages = {   
  'Disaster Resilience': {
    'description': '',
    #'description. description. description.',
    'foundations' : ['029', '030', '033', '034'],
    'default_foundation' : '029',
    'slides' : ['016'],
    'default_slide' : ['016']
    }
}

slides = {
  '016': {
    'name': 'points of interest',
    'endpoint':'http://service.civicpdx.org/disaster-resilience/sandbox/slides/poi/',
    'visualization': 'IconMap',
  }
}

foundations = {
  '029': {
    'name': 'Shaking Intensity',
    'endpoint':'http://service.civicpdx.org/disaster-resilience/sandbox/foundations/shaking/',
    'visualization': 'ChoroplethMap',
  },
  '030': {
    'name': 'Wet Season Mean Deformation Intensity',
    'endpoint':'http://service.civicpdx.org/disaster-resilience/sandbox/foundations/liquefaction/',
    'visualization': 'ChoroplethMap',
  },
  '033': {
    'name': 'Dry Season Mean Deformation Intensity',
    'endpoint':'http://service.civicpdx.org/disaster-resilience/sandbox/foundations/landslide/',
    'visualization': 'ChoroplethMap',
  },
  '034': {
    'name': 'Census Reponse Rate',
    'endpoint':'http://service.civicpdx.org/disaster-resilience/sandbox/foundations/censusresponse/',
    'visualization': 'ChoroplethMap',
  }
}

package_info = {
    'packages' : packages,
    'slides' : slides,
    'foundations' : foundations
    }