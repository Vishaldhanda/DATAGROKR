from banking import (
    SavingsAccount,
    CurrentAccount,
    AccountNotFoundError,
    BankingError,
    save_transactions,
    save_accounts
)


accounts = {}


def create_account():
    account_number = input("Enter account number: ").strip()

    if account_number in accounts:
        print("Account already exists.")
        return

    name = input("Enter account holder name: ").strip()

    if not name:
        print("Name cannot be empty.")
        return

    print("\n1. Savings Account")
    print("2. Current Account")

    account_type = input("Choose account type: ")

    if account_type == "1":
        account = SavingsAccount(account_number, name)
    elif account_type == "2":
        account = CurrentAccount(account_number, name)
    else:
        print("Invalid account type.")
        return

    initial_deposit = float(input("Enter initial deposit: "))

    if initial_deposit < 0:
        print("Initial deposit cannot be negative.")
        return

    account.balance = initial_deposit
    accounts[account_number] = account

    print("\nAccount created successfully.")
    print("Account Type:", account.account_type())


def get_account(account_number):
    if account_number not in accounts:
        raise AccountNotFoundError("Account not found.")
    return accounts[account_number]


def deposit_money():
    account = get_account(input("Enter account number: "))
    amount = float(input("Enter deposit amount: "))
    account.deposit(amount)
    print("Deposit successful.")
    account.show_balance()


def withdraw_money():
    account = get_account(input("Enter account number: "))
    amount = float(input("Enter withdrawal amount: "))
    account.withdraw(amount)
    print("Withdrawal successful.")
    account.show_balance()


def transfer_money():
    sender_number = input("Enter sender account number: ")
    receiver_number = input("Enter receiver account number: ")

    if sender_number == receiver_number:
        print("Sender and receiver cannot be the same.")
        return

    sender = get_account(sender_number)
    receiver = get_account(receiver_number)

    amount = float(input("Enter transfer amount: "))
    sender.transfer(receiver, amount)

    print("Transfer successful.")

    print("\nSender:")
    sender.show_balance()

    print("\nReceiver:")
    receiver.show_balance()


def check_balance():
    account = get_account(input("Enter account number: "))
    account.show_balance()


def show_history():
    account = get_account(input("Enter account number: "))
    account.show_transactions()


def show_all_accounts():
    if not accounts:
        print("No accounts available.")
        return

    print("\n===== ALL ACCOUNTS =====")

    for account in accounts.values():
        print(
            f"{account.account_number} | "
            f"{account.name} | "
            f"{account.account_type()} | "
            f"₹{account.balance:.2f}"
        )


def main():
    while True:
        print("\n")
        print("=" * 45)
        print("          OOP BANKING SYSTEM")
        print("=" * 45)

        print("1. Create Account")
        print("2. Deposit")
        print("3. Withdraw")
        print("4. Transfer")
        print("5. Check Balance")
        print("6. Transaction History")
        print("7. Show All Accounts")
        print("8. Save and Exit")

        choice = input("\nEnter your choice: ")

        try:
            if choice == "1":
                create_account()
            elif choice == "2":
                deposit_money()
            elif choice == "3":
                withdraw_money()
            elif choice == "4":
                transfer_money()
            elif choice == "5":
                check_balance()
            elif choice == "6":
                show_history()
            elif choice == "7":
                show_all_accounts()
            elif choice == "8":
                save_transactions(accounts)
                save_accounts(accounts)
                print("\nData saved successfully.")
                print("Thank you for using the Banking System.")
                break
            else:
                print("Invalid choice.")

        except ValueError:
            print("Please enter a valid number.")
        except BankingError as e:
            print("Error:", e)
        except Exception as e:
            print("Unexpected error:", e)


if __name__ == "__main__":
    main()
