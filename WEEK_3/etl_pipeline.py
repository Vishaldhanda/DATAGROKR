import os
import requests
import pandas as pd

API_URL = "https://jsonplaceholder.typicode.com/users"


def fetch_data(url=API_URL):
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return response.json()


def transform_data(data):
    df = pd.DataFrame(data)

    df = df[
        ["id", "name", "username", "email", "phone", "website"]
    ]

    df["name"] = df["name"].str.strip()
    df["username"] = df["username"].str.lower()
    df["email"] = df["email"].str.lower()
    df["email_domain"] = df["email"].str.split("@").str[-1]
    df["name_length"] = df["name"].str.len()

    return df


def save_data(df, filename="output/users_cleaned.csv"):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    df.to_csv(filename, index=False)


def run_pipeline():
    data = fetch_data()
    df = transform_data(data)
    save_data(df)
    return df


if __name__ == "__main__":
    df = run_pipeline()
    print("\n===== ETL PIPELINE =====")
    print("Data fetched and transformed successfully.")
    print("\n===== TRANSFORMED DATA =====")
    print(df)
    print("\n===== OUTPUT =====")
    print("Data saved to output/users_cleaned.csv")
