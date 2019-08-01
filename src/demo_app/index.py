import argparse

import callbacks
from app import app
from dotenv import load_dotenv
from layouts import page_layout

app.layout = page_layout()

if __name__ == "__main__":
    load_dotenv()

    parser = argparse.ArgumentParser()
    parser.add_argument("--development", action="store_true")
    args = parser.parse_args()

    if args.development:
        app.run_server(port=8052, debug=True)
    else:
        app.run_server(host="0.0.0.0", port=8052)
