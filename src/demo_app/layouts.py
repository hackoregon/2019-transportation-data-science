import json

import dash_core_components as dcc
import dash_html_components as html

import functions as func


def page_layout():
    """ Generate the main app page. """
    return html.Div(
        className="container-fluid",
        children=[
            html.Nav(
                id="header-bar",
                className="navbar navbar-dark",
                children=[
                    html.Img(className="img-responsive", src="./assets/logo.svg"),
                    html.Span(
                        className="row justify-content-left",
                        id="header-title",
                        children=["Transportation Systems"],
                    ),
                ],
            ),
            html.Div(
                className="row justify-content-center",
                id="title",
                children=["Disturbance Stop Heat Map - Hawthorne Pro Time Bus Lanes"],
            ),
            html.Div(
                className="row",
                children=[
                    html.Div(
                        className="col-6",
                        children=[
                            html.Div(
                                className="row justify-content-center mx-auto",
                                children=[
                                    html.Iframe(
                                        id="before-map",
                                        srcDoc=func.get_heatmap_as_html(),
                                        width="100%",
                                        height="500px",
                                    )
                                ],
                            ),
                            html.Div(
                                className="row justify-content-center",
                                id="before-title",
                                children=["2017"],
                            ),
                        ],
                    ),
                    html.Div(
                        className="col-6",
                        children=[
                            html.Div(
                                className="row justify-content-center mx-auto",
                                children=[
                                    html.Iframe(
                                        id="after-map",
                                        srcDoc=func.get_heatmap_as_html(),
                                        width="100%",
                                        height="500px",
                                    )
                                ],
                            ),
                            html.Div(
                                className="row justify-content-center",
                                id="after-title",
                                children=["2018"],
                            ),
                        ],
                    ),
                ],
            ),
            html.Div(
                className="row justify-content-center",
                children=[
                    html.Div(
                        className="col-10",
                        children=[
                            dcc.RangeSlider(
                                id="time-slider",
                                min=6,
                                max=12,
                                value=[6, 12],
                                step=0.25,
                                pushable=1,
                                marks={
                                    6: {"label": "6 am"},
                                    7: {"label": "7 am"},
                                    8: {"label": "8 am"},
                                    9: {"label": "9 am"},
                                    10: {"label": "10 am"},
                                    11: {"label": "11 am"},
                                    12: {"label": "12 pm"},
                                },
                            )
                        ],
                    )
                ],
            ),
            html.Div(
                className="row justify-content-center",
                children=[
                    html.Div(
                        className="col-10",
                        children=[
                            dcc.RangeSlider(
                                id="month-slider",
                                min=9,
                                max=11,
                                value=[9, 11],
                                step=1,
                                marks={
                                    9: {"label": "SEP"},
                                    10: {"label": "OCT"},
                                    11: {"label": "NOV"},
                                },
                            )
                        ],
                    )
                ],
            ),
        ],
    )

