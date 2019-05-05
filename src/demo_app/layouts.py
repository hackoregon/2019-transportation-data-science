import json

import dash_core_components as dcc
import dash_html_components as html

import functions as func


def page_layout():
    """ Generate the main app page. """
    return html.Div(className='container-fluid', children=[
        html.Nav(id='header-bar', className='navbar navbar-dark', children=[
            html.Img(className='img-responsive', src='./assets/logo.svg'),
            html.Span(className='row justify-content-left', id='header-title', children=['Transportation Systems'])
            ]),

        html.Div(className='row justify-content-center', id='title', children=['Disturbance Stop Heat Map - Hawthorne Pro Time Bus Lanes']),

        html.Div(className='row', children=[      
            html.Div(className='col-6', children=[
                html.Div(className='row justify-content-center mx-auto', children=[
                    html.Iframe(id='before-map', srcDoc=func.get_heatmap_as_html(), width='100%', height='650px')
                    ]),
                html.Div(className='row justify-content-center', id='before-title', children=['2017'])
            ]),
            html.Div(className='col-6', children=[
                html.Div(className='row justify-content-center mx-auto', children=[
                    html.Iframe(id='after-map', srcDoc=func.get_heatmap_as_html(), width='100%', height='650px')
                    ]),
                html.Div(className='row justify-content-center', id='after-title', children=['2018'])
            ])
        ]),

        html.Div(className='row justify-content-center', children=[
            html.Div(className='col-10', children=[
                dcc.RangeSlider(
                    id='time-slider',
                    min=0,
                    max=6,
                    value=[0, 6],
                    step=1,
                    pushable=1,
                    marks={
                        0: {'label': '6 am'},
                        1: {'label': '7 am'},
                        2: {'label': '8 am'},
                        3: {'label': '9 am'},
                        4: {'label': '10 am'},
                        5: {'label': '11 am'},
                        6: {'label': '12 pm'},
                        })
            ])
        ]),

        html.Div(className='row justify-content-center', children=[
            html.Div(className='col-10', children=[
                dcc.RangeSlider(
                    id='month-slider',
                    min=0,
                    max=2,
                    value=[0, 2],
                    step=1,
                    marks={
                        0: {'label': 'SEP'},
                        1: {'label': 'OCT'},
                        2: {'label': 'NOV'},
                        })
            ])
        ]),
    ])
