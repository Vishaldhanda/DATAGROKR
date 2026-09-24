# Week 3 ETL Pipeline + Tests

A Python ETL pipeline that fetches data from a REST API, transforms the data using Pandas, saves the result to CSV, and validates the transformation using Pytest.

## Technologies

- Python
- REST API
- Requests
- Pandas
- Pytest
- CSV

## Pipeline

REST API
↓
Fetch JSON
↓
Transform with Pandas
↓
Clean Data
↓
Create Derived Columns
↓
Save CSV
↓
Run Pytest

## Features

- Fetch data from REST API
- Convert JSON data into Pandas DataFrame
- Clean text data
- Convert emails and usernames to lowercase
- Extract email domain
- Calculate name length
- Save transformed data to CSV
- Unit testing using Pytest

## Project Structure

```text
week3-etl-pipeline/
├── etl_pipeline.py
├── test_etl_pipeline.py
├── output/
│   └── users_cleaned.csv
├── requirements.txt
├── README.md
└── .gitignore
```

## Installation

```bash
python -m venv venv
```

Windows PowerShell:

```bash
venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
pip install -r requirements.txt
```

## Run ETL Pipeline

```bash
python etl_pipeline.py
```

## Run Tests

```bash
pytest
```
