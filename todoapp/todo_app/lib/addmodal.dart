import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/todostructure.dart';

class AddTodoModal extends StatefulWidget {
  final void Function(Todostructure) onAddTodo;

  const AddTodoModal({super.key, required this.onAddTodo});

  @override
  State<AddTodoModal> createState() => _AddTodoModalState();
}

class _AddTodoModalState extends State<AddTodoModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _submit() {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        _selectedDate == null ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields.")));
      return;
    }

    final newTodo = Todostructure(
      title: _titleController.text,
      description: _descController.text,
      date: _selectedDate!,
      category: _selectedCategory!,
    );

    widget.onAddTodo(newTodo);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add New Task",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _selectedDate == null
                            ? 'Pick Date'
                            : DateFormat.yMMMd().format(_selectedDate!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Priority'),
                      items: Category.values.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
