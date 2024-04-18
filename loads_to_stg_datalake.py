import datetime
import io
import os
import requests
import pandas as pd
import numpy as np
from io import BytesIO
import warnings
from google.cloud import storage

init_path = "data/UEFA Champions League 2016-2022 Data.xlsx"
sheets = ["teams", "stadiums", "players", "managers", "matches", "goals"]
BUCKET = os.environ.get("GCP_GCS_BUCKET", "dezoomcamp2024_capstone")


def upload_to_gcs(bucket, object_name, local_file):
    """
    Ref: https://cloud.google.com/storage/docs/uploading-objects#storage-upload-object-python
    """
    # # WORKAROUND to prevent timeout for files > 6 MB on 800 kbps upload speed.
    # # (Ref: https://github.com/googleapis/python-storage/issues/74)
    storage.blob._MAX_MULTIPART_SIZE = 5 * 1024 * 1024  # 5 MB
    storage.blob._DEFAULT_CHUNKSIZE = 5 * 1024 * 1024  # 5 MB

    client = storage.Client()
    bucket = client.bucket(bucket)
    blob = bucket.blob(object_name)
    blob.upload_from_filename(local_file)


def get_data_type(sheet_name: str):
    data_types = {}
    if sheet_name == "teams":
        data_types = {
            "team_name": str,
            "country": str,
            "home_stadium": str
        }
    elif sheet_name == "stadiums":
        data_types = {
            "name": str,
            "city": str,
            "country": str,
            "capacity": 'int64'
        }
    elif sheet_name == "players":
        data_types = {
            "player_id": str,
            "first_name": str,
            "last_name": str,
            "nationality": str,
            "dob": datetime.date,
            "team": str,
            "jersey_number": 'int64',
            "position": str,
            "height": 'int64',
            "weight": 'int64',
            "foot": str
        }
    elif sheet_name == "managers":
        data_types = {
            "first_name": str,
            "last_name": str,
            "nationality": str,
            "dob": datetime.date,
            "team": str,
        }
    elif sheet_name == "matches":
        data_types = {
            "match_id": str,
            "season": str,
            "date_time": datetime.datetime,
            "home_team": str,
            "away_team": str,
            "stadium": str,
            "home_team_score": 'int64',
            "away_team_score": 'int64',
            "penalty_shoot_out": 'int64',
            "attendance": 'int64'
        }
    elif sheet_name == "goals":
        data_types = {
            "goal_id": str,
            "match_id": str,
            "pid": str,
            "duration": 'int64',
            "assist": str,
            "goal_desc": str
        }
    else:
        warnings.warn(
            f"Unknown sheer: {sheet_name}!")
        return
    return data_types


def get_data_from_excel_file(url: str, sheets=list[str]):
    for sheet in sheets:
        # sheet = "players"
        file_name = f"data/{sheet}.csv"
        data_types = get_data_type(sheet)
        df = pd.read_excel(io=url, sheet_name=sheet,
                           dtype=data_types)
        df.columns = df.columns.str.lower()
        df.to_csv(file_name, index=False)


def main():
    print("python main function")
    get_data_from_excel_file(init_path, sheets=sheets)


if __name__ == '__main__':
    main()
