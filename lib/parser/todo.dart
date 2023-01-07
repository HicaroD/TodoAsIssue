class Todo {
  final bool wasPosted;
  final String title;
  final String body;

  Todo({
    required this.wasPosted,
    required this.title,
    required this.body,
  });

  @override
  String toString() {
    return "[$wasPosted]('$title')('$body')";
  }
}
