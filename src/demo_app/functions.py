import folium
import pandas as pd
from folium import plugins


def load_disturbance_csvs():
    old_df = pd.read_csv("./data/old_disturbance.csv")
    old_df["SERVICE_DATE"] = pd.to_datetime(
        old_df["SERVICE_DATE"], format="%d%b%Y:%H:%M:%S"
    )

    new_df = pd.read_csv("./data/new_disturbance.csv")
    new_df["SERVICE_DATE"] = pd.to_datetime(
        new_df["SERVICE_DATE"], format="%d%b%y:%H:%M:%S"
    )

    df = old_df.append(new_df)

    return df


def filter_to_pts(df, date_str, time_s_str, point_type):
    # point_type should be 'delay' or 'ESTIMATED_LOAD'
    df = df[
        (df.SERVICE_DATE >= date_str[0])
        & (df.SERVICE_DATE <= date_str[1])
        & (df.depart >= time_s_str[0])
        & (df.depart <= time_s_str[1])
    ]

    pts = (
        df.loc[:, ["GPS_LATITUDE", "GPS_LONGITUDE", point_type]]
        .groupby(["GPS_LATITUDE", "GPS_LONGITUDE"])
        .sum()
        .reset_index()
        .values.tolist()
    )

    return pts


def get_heatmap_as_html(pts=None):
    heat_map = folium.Map(
        [45.512835, -122.659], tiles="Cartodb Positron", zoom_start=17
    )
    if pts:
        folium.plugins.HeatMap(
            pts,
            radius=5,
            gradient={0.2: "blue", 0.3: "lime", 0.5: "red"},
            min_opacity=0.5,
        ).add_to(heat_map)

    return heat_map.get_root().render()


def update_map(map_, time, month):
    df = load_disturbance_csvs()
    month_s = {
        "start": get_month_start_date(map_, month),
        "end": get_month_end_date(map_, month),
    }

    pts = filter_to_pts(
        df=df,
        date_str=[month_s["start"], month_s["end"]],
        time_s_str=[time["start"], time["end"]],
        point_type="delay",
    )

    html_str = get_heatmap_as_html(pts)

    return html_str


def get_month_start_date(map_, month):
    if month["start"] == "SEP":
        if map_ == "before":
            return "2017-09-01"
        elif map_ == "after":
            return "2018-09-01"
    elif month["start"] == "OCT":
        if map_ == "before":
            return "2017-10-01"
        elif map_ == "after":
            return "2018-10-01"
    elif month["start"] == "NOV":
        if map_ == "before":
            return "2017-11-01"
        elif map_ == "after":
            return "2018-11-01"
    else:
        return None


def get_month_end_date(map_, month):
    if month["end"] == "SEP":
        if map_ == "before":
            return "2017-09-30"
        elif map_ == "after":
            return "2018-09-30"
    elif month["end"] == "OCT":
        if map_ == "before":
            return "2017-10-31"
        elif map_ == "after":
            return "2018-10-31"
    elif month["end"] == "NOV":
        if map_ == "before":
            return "2017-11-30"
        elif map_ == "after":
            return "2018-11-30"
    else:
        return None
