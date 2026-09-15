import csv
from datetime import datetime
from functools import wraps


class BankingError(Exception):
    pass


class AccountNotFoundError(BankingError):
    pass


class InsufficientBalanceError(BankingError):
    pass


class InvalidAmountError(BankingError):
    pass


def transaction_logger(func):
    @wraps(func)
    def wrapper(self, *args, **kwargs):
        result = func(self, *args, **kwargs)
        return result
    return wrapper


class BankAccount:

    def __init__(self, account_number, name, balance=0):
        self.account_number = account_number
        self.name = name
        self.balance = float(balance)
        self.transactions = []

    @transaction_logger
    def deposit(self, amount):
        amount = float(amount)

        if amount <= 0:
            raise InvalidAmountError("Amount must be greater than zero.")

        self.balance += amount
        self.add_transaction("Deposit", amount)

    @transaction_logger
    def withdraw(self, amount):
        amount = float(amount)

        if amount <= 0:
            raise InvalidAmountError("Amount must be greater than zero.")

        if amount > self.balance:
            raise InsufficientBalanceError("Insufficient balance.")

        self.balance -= amount
        self.add_transaction("Withdrawal", amount)

    @transaction_logger
    def transfer(self, target_account, amount):
        amount = float(amount)

        if amount <= 0:
            raise InvalidAmountError("Amount must be greater than zero.")

        if amount > self.balance:
            raise InsufficientBalanceError("Insufficient balance.")

        self.balance -= amount
        target_account.balance += amount

        self.add_transaction(
            f"Transfer to {target_account.account_number}",
            amount
        )

        target_account.add_transaction(
            f"Transfer from {self.account_number}",
            amount
        )

    def add_transaction(self, transaction_type, amount):
        self.transactions.append({
            "date": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "account_number": self.account_number,
            "type": transaction_type,
            "amount": amount,
            "balance": self.balance
        })

    def show_balance(self):
        print(f"\nAccount Holder : {self.name}")
        print(f"Account Number : {self.account_number}")
        print(f"Account Type   : {self.account_type()}")
        print(f"Balance        : ₹{self.balance:.2f}")

    def show_transactions(self):
        if not self.transactions:
            print("\nNo transactions found.")
            return

        print("\n===== TRANSACTION HISTORY =====")

        for transaction in self.transactions:
            print(
                f"{transaction['date']} | "
                f"{transaction['type']} | "
                f"₹{transaction['amount']:.2f} | "
                f"Balance: ₹{transaction['balance']:.2f}"
            )

    def account_type(self):
        return "Bank Account"


class SavingsAccount(BankAccount):

    def account_type(self):
        return "Savings Account"


class CurrentAccount(BankAccount):

    def account_type(self):
        return "Current Account"


class CSVManager:

    def __enter__(self):
        self.file = open("transactions.csv", "w", newline="")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.file.close()


def save_transactions(accounts):

    with CSVManager() as manager:
        fieldnames = [
            "date",
            "account_number",
            "type",
            "amount",
            "balance"
        ]

        writer = csv.DictWriter(
            manager.file,
            fieldnames=fieldnames
        )

        writer.writeheader()

        for account in accounts.values():
            for transaction in account.transactions:
                writer.writerow(transaction)


def save_accounts(accounts):

    with open("accounts.csv", "w", newline="") as file:
        fieldnames = [
            "account_number",
            "name",
            "account_type",
            "balance"
        ]

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()

        for account in accounts.values():
            writer.writerow({
                "account_number": account.account_number,
                "name": account.name,
                "account_type": account.account_type(),
                "balance": account.balance
            })
