import pandas as pd
from etl_pipeline import transform_data


def sample_data():
    return [
        {
            "id": 1,
            "name": "  John Doe  ",
            "username": "JohnDoe",
            "email": "JOHN@EXAMPLE.COM",
            "phone": "123456789",
            "website": "example.com"
        },
        {
            "id": 2,
            "name": "Jane Smith",
            "username": "JaneSmith",
            "email": "JANE@TEST.COM",
            "phone": "987654321",
            "website": "test.com"
        }
    ]


def test_transform_returns_dataframe():
    df = transform_data(sample_data())
    assert isinstance(df, pd.DataFrame)


def test_transform_columns():
    df = transform_data(sample_data())
    expected_columns = [
        "id",
        "name",
        "username",
        "email",
        "phone",
        "website",
        "email_domain",
        "name_length"
    ]
    assert list(df.columns) == expected_columns


def test_name_cleaning():
    df = transform_data(sample_data())
    assert df.loc[0, "name"] == "John Doe"


def test_email_lowercase():
    df = transform_data(sample_data())
    assert df.loc[0, "email"] == "john@example.com"


def test_email_domain():
    df = transform_data(sample_data())
    assert df.loc[0, "email_domain"] == "example.com"


def test_name_length():
    df = transform_data(sample_data())
    assert df.loc[0, "name_length"] == 8


def test_row_count():
    df = transform_data(sample_data())
    assert len(df) == 2
