class Todo {
  final int id;
  final bool wasPosted;
  final String title;

  Todo({required this.id, required this.wasPosted, required this.title});

  @override
  String toString() {
    return "($id)[$wasPosted]('$title')";
  }
}
