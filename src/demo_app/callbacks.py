from dash.dependencies import Input, Output

import functions as func
from app import app


@app.callback(
    output=Output("before-map", "srcDoc"),
    inputs=[Input("time-slider", "value"), Input("month-slider", "value")],
)
def update_before_map(t_value, m_value):
    """
    Triggered by either slider change. Returns folium HTML string to map container.
    """
    _time = {"start": t_value[0], "end": t_value[1]}

    month = {"start": m_value[0], "end": m_value[1]}

    return func.update_map(map_="before", time=_time, month=month, year="2017")


@app.callback(
    output=Output("after-map", "srcDoc"),
    inputs=[Input("time-slider", "value"), Input("month-slider", "value")],
)
def update_after_map(t_value, m_value):
    """
    Triggered by either slider change. Returns folium HTML string to map container.
    """
    _time = {"start": t_value[0], "end": t_value[1]}

    month = {"start": m_value[0], "end": m_value[1]}

    return func.update_map(map_="after", time=_time, month=month, year="2018")
