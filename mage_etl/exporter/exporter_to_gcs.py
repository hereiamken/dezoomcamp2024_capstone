from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

sheets = ["teams", "managers", "goals", "players", "stadiums", "matches"]
@data_exporter
def export_data_to_google_cloud_storage(df1: DataFrame, df2: DataFrame, df3: DataFrame, df4: DataFrame, df5: DataFrame, df6: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    dfs = [df1, df2, df3, df4, df5, df6]
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    idx = 0
    bucket_name = 'dezoomcamp2024_capstone'
    for table in sheets:
        object_key = f'{table}.csv'

        GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
            dfs[idx],
            bucket_name,
            object_key,
        )

        idx = idx + 1
