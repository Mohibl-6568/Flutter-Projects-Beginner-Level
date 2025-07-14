import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    final totalSpent = expenses.fold<double>(
      0.0,
      (sum, expense) => sum + (double.tryParse(expense.amount) ?? 0.0),
    );

    final Map<Category, double> categoryTotals = {};
    for (var expense in expenses) {
      final amount = double.tryParse(expense.amount) ?? 0.0;
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0.0) + amount;
    }

    final categories = Category.values;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Category Spending',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: categories.map((category) {
                final categoryTotal = categoryTotals[category] ?? 0.0;
                final fillRatio = totalSpent == 0
                    ? 0.0
                    : categoryTotal / totalSpent;

                return Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 150,
                        width: 50,
                        decoration: BoxDecoration(
                          //border: Border.,
                          color: Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: fillRatio.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Expense.categoryIcons(category),
                        size: 20,
                        color: Color(0xFF4CAF50),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
