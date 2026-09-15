import pandas as pd
import numpy as np


df = pd.read_csv("transactions.csv")

print("\n===== TRANSACTION DATA =====")
print(df)

print("\n===== DATA INFORMATION =====")
df.info()

print("\n===== STATISTICS =====")
print(df["amount"].describe())

print("\n===== TOTAL TRANSACTION AMOUNT =====")
print(df["amount"].sum())

print("\n===== AVERAGE TRANSACTION AMOUNT =====")
print(df["amount"].mean())

print("\n===== TRANSACTIONS BY TYPE =====")
transaction_summary = df.groupby("type")["amount"].agg(
    ["count", "sum", "mean"]
)
print(transaction_summary)

print("\n===== TRANSACTIONS BY ACCOUNT =====")
account_summary = df.groupby("account_number")["amount"].agg(
    ["count", "sum", "mean"]
)
print(account_summary)

print("\n===== TRANSACTIONS ABOVE ₹5000 =====")
print(df[df["amount"] > 5000])

print("\n===== DEPOSITS =====")
print(df[df["type"] == "Deposit"])

print("\n===== WITHDRAWALS =====")
print(df[df["type"] == "Withdrawal"])

print("\n===== NUMPY ANALYSIS =====")
amounts = np.array(df["amount"])
print("Maximum:", np.max(amounts))
print("Minimum:", np.min(amounts))
print("Mean:", np.mean(amounts))
print("Standard Deviation:", np.std(amounts))

print("\n===== LIST COMPREHENSION =====")
amount_list = [amount for amount in df["amount"] if amount > 1000]
print(amount_list)

print("\n===== DICTIONARY COMPREHENSION =====")
account_totals = {
    account: total
    for account, total
    in df.groupby("account_number")["amount"].sum().items()
}
print(account_totals)

print("\n===== LAMBDA =====")
sorted_transactions = df.sort_values(
    by="amount",
    key=lambda x: x,
    ascending=False
)
print(sorted_transactions)

print("\n===== MAP =====")
df["amount_with_tax"] = list(
    map(lambda x: x * 1.01, df["amount"])
)
print(df[["amount", "amount_with_tax"]])

print("\n===== FILTER =====")
high_value_transactions = list(
    filter(lambda x: x > 5000, df["amount"])
)
print(high_value_transactions)

print("\n===== TOP TRANSACTIONS =====")
print(df.nlargest(5, "amount"))
