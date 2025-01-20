import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String title;
  double amount;
  DateTime date;
  String id;
  Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenseList});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenseList = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenseList;

  double get totalExpenses {
    double sum = 0;
    for (Expense expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
