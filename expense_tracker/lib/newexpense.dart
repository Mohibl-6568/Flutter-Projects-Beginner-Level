import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense.dart';

final formatter = DateFormat('dd/MM/yyyy');

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;
  const NewExpense({required this.onAddExpense, super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titlecontroller = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category? selectedCategory;

  void checkIfNull() {
    if (titlecontroller.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null ||
        selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please fill all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    } else {
      final enteredTitle = titlecontroller.text;
      final enteredAmount = amountController.text;
      final enteredDate = selectedDate!;
      final enteredCategory = selectedCategory!;

      final newExpense = Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: enteredDate,
        category: enteredCategory,
      );

      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      } else {
        setState(() {
          this.selectedDate = selectedDate;
        });
      }
    });
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                //color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            'Add New Expense',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: titlecontroller,
            decoration: const InputDecoration(labelText: 'Title'),
            maxLength: 50,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              const Text('Category:'),
              const SizedBox(width: 10),
              DropdownButton(
                value: selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(children: [Text(category.name.toUpperCase())]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: presentDatePicker,
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : formatter.format(selectedDate!),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: checkIfNull,
                child: const Text('Save Expense'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
