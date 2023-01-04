class Todo {
  final bool wasPosted;
  final String title;

  Todo({required this.wasPosted, required this.title});

  @override
  String toString() {
    return "[$wasPosted]('$title')";
  }
}
