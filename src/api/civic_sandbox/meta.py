
poi_meta = {
  'attributes': {
    'primary': {
      'field': 'type',
      'name': 'Type',
    },
    'secondary': {
      'field': 'description_txt',
      'name': 'Name',
    },
  },
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2017',
    'min_date': None, 
    'max_date': None,
    },
  }


shaking_meta = {
  'attributes': {
    'primary': {
      'field': 'pgv_site_mean_mmi_txt',
      'name': 'Shaking Intensity Rating',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
      },
    },
    'secondary': {
      'field': 'pgv_site_mean_desc',
      'name': 'Description:',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
    },
  },
}, 
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2018',
    'min_date': None,
    'max_date': None,
    },
  }

shaking_meta = {
  'attributes': {
    'primary': {
      'field': 'pgv_site_mean_mmi_txt',
      'name': 'Shaking Intensity Rating',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
      },
    },
    'secondary': {
      'field': 'pgv_site_mean_desc',
      'name': 'Description',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
    },
  },
}, 
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2018',
    'min_date': None,
    'max_date': None,
    },
  }

liquefaction_meta = {
  'attributes': {
    'primary': {
      'field': 'pgd_total_wet_mean_di',
      'name': 'Total Wet Mean DI Label',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
      },
    },
    'secondary': {
      'field': None,
      'name': None,
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
    },
  },
}, 
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2018',
    'min_date': None,
    'max_date': None,
    },
  }

landslide_meta = {
  'attributes': {
    'primary': {
      'field': 'pgd_landslide_dry_mean_di',
      'name': 'Landslide Dry Mean DI Label',
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
      },
    },
    'secondary': {
      'field': None,
      'name': None,
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
    },
  },
}, 
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2018',
    'min_date': None,
    'max_date': None,
    },
  }

census_response_meta = {
  'attributes': {
    'primary': {
      'field': 'census_response_rate',
      'name': 'Census Response Rate',
      'visualization': {
        'type': 'PercentDonut',
        'comparison_value': None,
        'comparison_name': None, 
      },
    },
    'secondary': {
      'field': None,
      'name': None,
      'visualization': {
        'type': 'Text',
        'comparison_value': None,
        'comparison_name': None, 
    },
  },
}, 
    'dates': {
    'date_attribute': None,
    'date_granularity': None,
    'default_date_filter': '2010',
    'min_date': None,
    'max_date': None,
    },
  }