import csv
import json
import sqlite3
import time

import pandas as pd

with open('./db_config.json') as fobj:
    CONFIG = json.load(fobj)

disturbance_query = (
        """
        WITH 
        se1 AS (
        SELECT
            stop_events.SERVICE_DATE,
            stop_events.SERVICE_KEY,
            stop_events.TRAIN,
            stop_events.TRIP_NUMBER,
            stop_events.VEHICLE_NUMBER as bus,
            stop_events.ROUTE_NUMBER,
            stop_events.DIRECTION,
            stop_events.LOCATION_ID as start_stop,
            stop_events.ARRIVE_TIME as start_arrive,
            stop_events.LEAVE_TIME as start_leave,
            stop_events.ESTIMATED_LOAD
        FROM
            "trimet_stop_event" as stop_events
        WHERE
            stop_events.LOCATION_ID in (3637, 2642, 7856) AND
            stop_events.ROUTE_NUMBER in (2, 4, 10, 14)
        ), 
        se2 AS (
        SELECT
            stop_events.SERVICE_DATE,
            stop_events.SERVICE_KEY,
            stop_events.TRAIN,
            stop_events.TRIP_NUMBER,
            stop_events.VEHICLE_NUMBER as bus,
            stop_events.ROUTE_NUMBER,
            stop_events.DIRECTION,
            stop_events.LOCATION_ID as end_stop,
            stop_events.ARRIVE_TIME as end_arrive,
            stop_events.LEAVE_TIME as end_depart,
            stop_events.ESTIMATED_LOAD
        FROM
            "trimet_stop_event" as stop_events
        WHERE
            stop_events.LOCATION_ID in (3637, 2642, 7856) AND
            stop_events.ROUTE_NUMBER in (2, 4, 10, 14)
        ),
        se AS (
        SELECT 
            se1.SERVICE_DATE,
            se1.SERVICE_KEY,
            se1.TRAIN,
            se1.TRIP_NUMBER,
            se1.bus,
            se1.ROUTE_NUMBER,
            se1.DIRECTION,
            se1.ESTIMATED_LOAD,
            CASE
                WHEN se1.start_stop in (3637, 7856)  THEN se1.start_stop
            END as start_location,
            CASE
                WHEN se1.start_stop in (3637, 7856) THEN se1.start_leave
            END as depart,
            CASE
                WHEN se2.end_stop = 2642 THEN se2.end_stop
            END as end_location,
            CASE
                WHEN se2.end_stop = 2642 THEN se2.end_arrive
            END as arrive
        FROM se1
        LEFT JOIN se2
        ON 
            (se1.SERVICE_DATE = se2.SERVICE_DATE) AND
            (se1.TRAIN = se2.TRAIN) AND
            (se1.TRIP_NUMBER = se2.TRIP_NUMBER) AND
            (se1.bus = se2.bus) AND
            (se1.ROUTE_NUMBER = se2.ROUTE_NUMBER) AND
            (se1.DIRECTION = se2.DIRECTION)
        WHERE
            start_location IS NOT NULL AND
            end_location IS NOT NULL)
        SELECT
            se.SERVICE_DATE,
            se.SERVICE_KEY,
            se.TRAIN,
            se.TRIP_NUMBER,
            se.bus,
            se.ROUTE_NUMBER,
            se.DIRECTION,
            se.ESTIMATED_LOAD,
            se.start_location,
            se.depart,
            se.end_location,
            se.arrive,
            vh.ACT_ARR_TIME,
            vh.ACT_DEP_TIME,
            vh.STOP_TYPE,
            vh.GPS_LONGITUDE,
            vh.GPS_LATITUDE,
            vh.ACT_DEP_TIME - vh.ACT_ARR_TIME as delay,
            vh.DOOR_OPEN_TIME
        FROM se
        INNER JOIN "init_veh_stoph" as vh on 
            vh.OPD_Date = se.SERVICE_DATE and 
            vh.VEHICLE_ID = se.bus AND
            vh.ACT_ARR_TIME BETWEEN se.depart AND se.arrive AND 
            vh.STOP_TYPE = "3" AND
            se.SERVICE_KEY = "W"
        """
    )

headers =   [
    "SERVICE_DATE",
    "SERVICE_KEY",
    "TRAIN",
    "TRIP_NUMBER",
    "bus",
    "ROUTE_NUMBER",
    "DIRECTION",
    "ESTIMATED_LOAD",
    "start_location",
    "depart",
    "end_location",
    "arrive",
    "ACT_ARR_TIME",
    "ACT_DEP_TIME",
    "STOP_TYPE",
    "GPS_LONGITUDE",
    "GPS_LATITUDE",
    "delay",
    "DOOR_OPEN_TIME"
]

overall_start = time.time()
print('Begin.')

for ver in ['old', 'new']:
    db_name = f"{ver}_raw.db"

    query_start = time.time()
    print(f"\tQuerying {db_name}\t", end='', flush=True)

    con = sqlite3.connect(f"./{db_name}")
    cur = con.cursor()
    cur.execute(disturbance_query)
    rows = cur.fetchall()
    print(f"Complete. [{time.time() - query_start:.0f}s]", flush=True)

    out_name = f'{ver}_disturbance.csv'
    write_start = time.time()
    print(f"\tWriting {out_name}\t", end='', flush=True)

    with open(f"{out_name}", 'w') as fobj:
        f = csv.writer(fobj)
        f.writerow(headers)
        f.writerows(rows)
    con.close()
    print(f"Complete. [{time.time() - write_start:.0f}s]", flush=True)

print(f"Done. Took {time.time() - overall_start:.0f}s.")

