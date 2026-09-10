def get_grade(average):
    if average >= 80:
        return "A"
    elif average >= 60:
        return "B"
    elif average >= 50:
        return "C"
    elif average >= 40:
        return "D"
    else:
        return "F"


def calculate_result(marks):
    total = sum(marks.values())
    average = total / len(marks)
    grade = get_grade(average)
    return total, average, grade


def display_result(name, marks, total, average, grade):
    print("\n" + "=" * 40)
    print("       STUDENT GRADE REPORT")
    print("=" * 40)
    print(f"Student Name : {name}")

    print("\nSubject Marks:")
    for subject, mark in marks.items():
        print(f"{subject}: {mark}")

    print("-" * 40)
    print(f"Total Marks  : {total}")
    print(f"Average      : {average:.2f}")
    print(f"Grade        : {grade}")
    print("=" * 40)


def main():
    while True:
        print("\n===== CLI GRADE CALCULATOR =====")

        name = input("Enter student name: ")

        while True:
            try:
                n = int(input("Enter number of subjects: "))

                if n > 0:
                    break
                else:
                    print("Number of subjects must be greater than 0.")

            except ValueError:
                print("Please enter a valid number.")

        marks = {}

        for i in range(n):
            subject = input(f"Enter subject {i + 1} name: ")

            while True:
                try:
                    mark = float(input(f"Enter marks for {subject}: "))

                    if 0 <= mark <= 100:
                        marks[subject] = mark
                        break
                    else:
                        print("Marks must be between 0 and 100.")

                except ValueError:
                    print("Please enter a valid number.")

        total, average, grade = calculate_result(marks)

        display_result(name, marks, total, average, grade)

        choice = input("\nCalculate another student? (y/n): ")

        if choice.lower() != "y":
            print("Thank you for using Grade Calculator!")
            break


if __name__ == "__main__":
    main()
