import 'package:flutter/material.dart';
import 'package:todo_app/addmodal.dart';
import 'package:todo_app/todostructure.dart';
import 'package:todo_app/todocardlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      themeMode: ThemeMode.dark,
      darkTheme: darkTodoTheme,
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todostructure> alldata = [
    Todostructure(
      title: "Buy Groceries",
      description: "Milk, Eggs, Bread",
      date: DateTime.now(),
      category: Category.low,
    ),
    Todostructure(
      title: "Complete Assignment",
      description: "Finish math assignment by tomorrow",
      date: DateTime.now().add(const Duration(days: 1)),
      category: Category.high,
    ),
  ];

  void onAddNewTodo(Todostructure newTodo) {
    setState(() {
      alldata.add(newTodo);
    });
  }

  void toggleCompletion(Todostructure task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void deleteTodo(Todostructure task) {
    setState(() {
      alldata.remove(task);
    });
  }

  /// 🔽 Sorting logic: High → Medium → Low, then Completed goes last
  List<Todostructure> get sortedTodos {
    List<Todostructure> sorted = [...alldata];

    sorted.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        // Completed tasks go to the bottom
        return a.isCompleted ? 1 : -1;
      }

      // Priority order: High (2) → Medium (1) → Low (0)
      int priority(Category cat) {
        switch (cat) {
          case Category.high:
            return 2;
          case Category.medium:
            return 1;
          case Category.low:
            return 0;
        }
      }

      return priority(b.category).compareTo(priority(a.category));
    });

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                context: context,
                builder: (_) => AddTodoModal(onAddTodo: onAddNewTodo),
              );
            },
          ),
        ],
      ),
      body: TodoCardList(
        alldata: sortedTodos,
        onToggleComplete: toggleCompletion,
        onDelete: deleteTodo,
      ),
    );
  }
}

/// Custom dark theme
final ThemeData darkTodoTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white60, fontSize: 16),
    labelLarge: TextStyle(color: Colors.white, fontSize: 14),
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.tealAccent[700],
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.tealAccent),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.tealAccent,
    foregroundColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    hintStyle: const TextStyle(color: Colors.white38),
    labelStyle: const TextStyle(color: Colors.white70),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.tealAccent),
    ),
  ),
  cardColor: const Color.fromARGB(255, 56, 55, 55),
  cardTheme: CardThemeData(
    color: const Color.fromARGB(255, 56, 55, 55),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  dividerColor: Colors.white24,
);
