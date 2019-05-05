import json
import sqlite3
import time

import pandas as pd

with open('./db_config.json') as fobj:
    CONFIG = json.load(fobj)

overall_start = time.time()
print('Begin.')

# init_veh_stoph or trimet_stop_events
for table in CONFIG.keys():
    # "old" or "new" - becuase format changed slightly
    for ver in CONFIG[table].keys():
        db_name = f"{ver}_raw.db"
        con = sqlite3.connect(f"./{db_name}")
        first_file = True
        for f in CONFIG[table][ver]['files']:
            read_start = time.time()
            print(f"\tReading {f}\t", end='', flush=True)

            df = pd.read_csv(f)

            print(f"Complete. [{time.time() - read_start:.0f}s]", flush=True)

            df.rename(CONFIG[table][ver]['names'], axis=1, inplace=True)

            if first_file:
                exists = 'replace'
                first_file = False
            else:
                exists='append'

            write_start = time.time()
            print(f"\tWriting {table} to {db_name}\t", end='', flush=True)

            df.to_sql(name=table, con=con, if_exists=exists, index=False, dtype=CONFIG[table][ver]['types'])
            
            print(f"Complete. [{time.time() - write_start:.0f}s]", flush=True)

con.close()
print(f"Done. Took {time.time() - overall_start:.0f}s.")
