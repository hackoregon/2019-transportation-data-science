import folium
import requests
from folium.plugins import HeatMap


def get_heatmap_as_html(pts=None):
    heat_map = folium.Map(
        [45.512835, -122.659], tiles="Cartodb Positron", zoom_start=17
    )
    if pts:
        HeatMap(
            pts,
            radius=5,
            gradient={0.2: "blue", 0.3: "lime", 0.5: "red"},
            min_opacity=0.5,
        ).add_to(heat_map)
    return heat_map.get_root().render()


def update_map(map_, time, month, year):
    months = "%2C".join([str(m) for m in range(month["start"], month["end"] + 1)])
    times = "%2C".join([str(t) for t in [time["start"], time["end"]]])

    url = f"http://localhost:8000/v1/transportation-systems/toad/disturbanceStops/?months={months}&time_range={times}&years={year}&directions=I&lines=14&service_key=W"

    r = requests.get(url)

    num_pts = r.json()['count']

    r = requests.get(url + f"&limit={num_pts}")
    pts = []

    while True:
        for p in r.json()["results"]["features"]:
            if p["geometry"] is not None:
                pts.append(p["geometry"]["coordinates"][::-1])
        if r.json()["next"] is not None:
            r = requests.get(r.json()["next"])
        else:
            break

    html_str = get_heatmap_as_html(pts)

    return html_str



