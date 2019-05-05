import json
import time

import dash
from dash.dependencies import Input, Output, State
from dash.exceptions import PreventUpdate

import functions as func
from app import app


@app.callback(
    output=Output("before-map", "srcDoc"),
    inputs=[Input("time-slider", "value"), Input("month-slider", "value")],
    state=[State("time-slider", "marks"), State("month-slider", "marks")],
)
def update_before_map(t_value, m_value, t_marks, m_marks):
    """ Triggered by either slider change. Returns folium HTML string to map container. """
    time = {
        "start": int(t_marks[str(t_value[0])]["label"].split(" ")[0]) * 60 * 60,
        "end": int(t_marks[str(t_value[1])]["label"].split(" ")[0]) * 60 * 60,
    }

    month = {
        "start": m_marks[str(m_value[0])]["label"].split(" ")[0],
        "end": m_marks[str(m_value[1])]["label"].split(" ")[0],
    }

    return func.update_map(map_="before", time=time, month=month)


@app.callback(
    output=Output("after-map", "srcDoc"),
    inputs=[Input("time-slider", "value"), Input("month-slider", "value")],
    state=[State("time-slider", "marks"), State("month-slider", "marks")],
)
def update_after_map(t_value, m_value, t_marks, m_marks):
    """ Triggered by either slider change. Returns folium HTML string to map container. """
    time = {
        "start": int(t_marks[str(t_value[0])]["label"].split(" ")[0]) * 60 * 60,
        "end": int(t_marks[str(t_value[1])]["label"].split(" ")[0]) * 60 * 60,
    }

    month = {
        "start": m_marks[str(m_value[0])]["label"].split(" ")[0],
        "end": m_marks[str(m_value[1])]["label"].split(" ")[0],
    }

    return func.update_map(map_="after", time=time, month=month)
