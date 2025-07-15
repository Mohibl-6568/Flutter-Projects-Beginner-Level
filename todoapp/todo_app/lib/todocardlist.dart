import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/todostructure.dart';

class TodoCardList extends StatelessWidget {
  final List<Todostructure> alldata;
  final void Function(Todostructure todo) onToggleComplete;
  final void Function(Todostructure todo) onDelete;

  const TodoCardList({
    super.key,
    required this.alldata,
    required this.onToggleComplete,
    required this.onDelete,
  });

  Color _categoryColor(Category category) {
    switch (category) {
      case Category.low:
        return Colors.greenAccent.shade400;
      case Category.medium:
        return Colors.amberAccent.shade400;
      case Category.high:
        return Colors.redAccent.shade200;
    }
  }

  IconData _categoryIcon(Category category) {
    switch (category) {
      case Category.low:
        return Icons.low_priority;
      case Category.medium:
        return Icons.priority_high;
      case Category.high:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (alldata.isEmpty) {
      return const Center(child: Text("No tasks yet."));
    }

    return ListView.builder(
      itemCount: alldata.length,
      itemBuilder: (context, index) {
        final todo = alldata[index];

        return Dismissible(
          key: ValueKey(todo.title + todo.date.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (_) => onDelete(todo),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: Icon(
                _categoryIcon(todo.category),
                color: _categoryColor(todo.category),
                size: 32,
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (todo.description.isNotEmpty)
                    Text(
                      todo.description,
                      style: TextStyle(color: Colors.grey[300], fontSize: 14),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    'Due: ${DateFormat.yMMMd().format(todo.date)}',
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
              trailing: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => onToggleComplete(todo),
                activeColor: Colors.tealAccent,
                checkColor: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
