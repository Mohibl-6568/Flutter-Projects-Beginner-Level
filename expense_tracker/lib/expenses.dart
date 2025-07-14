import 'package:expense_tracker/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/newexpense.dart';
import 'package:expense_tracker/expensebarchart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: "Dinner",
      amount: "29.99",
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Movie",
      amount: "16.99",
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void deleteExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted ${expense.title} successfully!',
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void onAddButtonPressed() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.85,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewExpense(onAddExpense: updateExpenseList),
        ),
      ),
    );
  }

  void updateExpenseList(Expense newExpense) {
    setState(() {
      registeredExpenses.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 4,
        titleTextStyle: const TextStyle(
          //color: Colors.white,
          //fontSize: 20,
          //fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: onAddButtonPressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            children: [
              ExpenseChart(expenses: registeredExpenses),
              Expanded(
                child: ExpenseList(
                  expenses: registeredExpenses,
                  onRemoveExpense: deleteExpense,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
