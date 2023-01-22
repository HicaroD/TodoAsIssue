class Issue {
  final bool wasPosted;
  final String title;
  final String body;
  final List<String> labels;

  Issue({
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
