import 'package:expense_tracker_app/models/expense.dart';

class ExpenseData {
  List<Expense> getExpenseData() {
    List<Expense> expenseList = [
      Expense(
          title: "Flutter Course",
          amount: 100.50,
          date: DateTime.now(),
          category: Category.work),
      Expense(
          title: "Cinema",
          amount: 200.50,
          date: DateTime.now(),
          category: Category.leisure),
    ];

    return expenseList;
  }
}
