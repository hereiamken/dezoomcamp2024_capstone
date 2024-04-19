import io
import pandas as pd
import requests
from pandas import DataFrame
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs) -> DataFrame:
    """
    Template for loading data from API
    """
    url = 'https://github.com/hereiamken/dezoomcamp2024_capstone/blob/main/data/managers.csv?raw=True'
    response = requests.get(url)

    return pd.read_csv(io.StringIO(response.text), sep=',', on_bad_lines='skip')


@test
def test_output(df) -> None:
    """
    Template code for testing the output of the block.
    """
    assert df is not None, 'The output is undefined'
