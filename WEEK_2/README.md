# Week 2 OOP Banking System

A Python mini-project demonstrating intermediate Python concepts through an OOP banking system and CSV dataset analysis.

## Features

- Create Savings and Current accounts
- Deposit money
- Withdraw money
- Transfer money between accounts
- Check account balance
- View transaction history
- Save account and transaction data to CSV
- Pandas data analysis
- NumPy calculations
- List and dictionary comprehensions
- Lambda, map and filter
- Decorators
- Custom context manager
- Custom exceptions
- Python modules

## Project Structure

```text
week2-banking-system/
├── main.py
├── banking.py
├── analysis.py
├── transactions.csv
├── accounts.csv
├── requirements.txt
├── README.md
└── .gitignore
```

## Requirements

Python 3.10 or newer is recommended.

## Setup

Create a virtual environment:

```bash
python -m venv venv
```

Activate it on Windows PowerShell:

```bash
venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
pip install -r requirements.txt
```

## Run Banking System

```bash
python main.py
```

Use the menu to create accounts and perform transactions.

Choose `8. Save and Exit` after testing so the CSV files are updated.

## Run Data Analysis

After running the banking system and generating transactions:

```bash
python analysis.py
```

## Technologies

- Python
- Pandas
- NumPy
- CSV
