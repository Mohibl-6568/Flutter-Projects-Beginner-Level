import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

enum Category { food, work, travel, leisure }

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final String amount;
  final DateTime date;
  final Category category;

  static IconData categoryIcons(Category category) {
    switch (category) {
      case Category.food:
        return Icons.fastfood;
      case Category.work:
        return Icons.work;
      case Category.travel:
        return Icons.travel_explore;
      case Category.leisure:
        return Icons.movie;
    }
  }
}

class ExpenseBucket {
  final List<Expense> expenses;

  ExpenseBucket(this.expenses);

  double get totalExpenses {
    double total = 0.0;
    for (var expense in expenses) {
      total += double.tryParse(expense.amount) ?? 0.0;
    }
    return total;
  }

  Map<Category, double> get categoryTotals {
    final Map<Category, double> totals = {};
    for (var expense in expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0.0) +
          (double.tryParse(expense.amount) ?? 0.0);
    }
    return totals;
  }
}
