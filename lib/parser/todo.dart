class Todo {
  final bool wasPosted;
  final String title;
  final String body;
  final List<String> labels;

  Todo({
    required this.wasPosted,
    required this.title,
    required this.body,
    required this.labels,
  });

  @override
  String toString() {
    return "[$wasPosted]('$title')('$body'){$labels}";
  }
}
