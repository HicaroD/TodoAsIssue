class Todo {
  final int id;
  final bool isClosed;
  final String title;

  Todo({required this.id, required this.isClosed, required this.title});

  @override
  String toString() {
    return "($id)[$isClosed]('$title')";
  }
}
