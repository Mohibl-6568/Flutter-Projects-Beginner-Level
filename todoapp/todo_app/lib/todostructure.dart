enum Category { low, medium, high }

class Todostructure {
  String title;
  String description;
  DateTime date;
  bool isCompleted;
  Category category;

  Todostructure({
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.category = Category.low,
  });
}
