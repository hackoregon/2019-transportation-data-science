from pathlib import Path

import pandas as pd


def check_available_files(folder):
    states = set()
    datasets = set()
    for f in external_folder.rglob("*.csv"):
        fields = f.stem.split("_")
        states.add(fields[0])
        datasets.add(fields[1])

    print(f"\tState(s): {', '.join(states)}\n\tDataset(s): {', '.join(datasets)}")

    return states, datasets


def parse_file(filename):
    df = pd.read_csv(filename, low_memory=False)

    fields = filename.stem.split("_")

    df["ST"] = fields[0]
    filetype = fields[1]

    if filetype == "od":
        df["PART"] = fields[2]
        df["TYPE"] = fields[3]
        df["YEAR"] = fields[4]
    elif filetype == "rac":
        df["SEG"] = fields[2]
        df["TYPE"] = fields[3]
        df["YEAR"] = fields[4]
    elif filetype == "wac":
        df["SEG"] = fields[2]
        df["TYPE"] = fields[3]
        df["YEAR"] = fields[4]
    elif filetype == "xwalk":
        pass
    else:
        print(f"Unknown filetype: {filetype}.")
        return None

    return df


if __name__ == "__main__":
    external_folder = Path("/Work/LODES")
    interim_folder = Path("/Work/LODES")

    if not interim_folder.is_dir():
        print(f"Output folder {interim_folder} not found, creating.")
        interim_folder.mkdir()

    print("Inspecting dataset.")
    states, datasets = check_available_files(external_folder)

    for dataset in datasets:
        print(f"Parsing {dataset} files.")
        df = pd.concat(
            [parse_file(f) for f in external_folder.rglob(f"*{dataset}*.csv")]
        )

        if dataset == "od":
            parsed_fields = ["ST", "PART", "TYPE", "YEAR"]
            id_vars = [*parsed_fields, "w_geocode", "h_geocode"]
        elif dataset == "rac":
            parsed_fields = ["ST", "SEG", "TYPE", "YEAR"]
            id_vars = [*parsed_fields, "h_geocode"]
        elif dataset == "wac":
            parsed_fields = ["ST", "TYPE", "YEAR"]
            id_vars = [*parsed_fields, "w_geocode"]
        elif dataset == "xwalk":
            parsed_fields = ["ST"]
            id_vars = [*parsed_fields, "tabblk2010"]
        else:
            print(f"Unknown dataset: {dataset}.")
            continue

        long_df = pd.melt(df, id_vars=id_vars)

        out_filename = interim_folder / f"lodes_{dataset}.csv"

        long_df.to_csv(out_filename, index=False)
