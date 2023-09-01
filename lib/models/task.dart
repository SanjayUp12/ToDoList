class Task {
  Task({required this.name, required this.isDone});
  String name = '';
  bool isDone = false;
  void isDoneToggle() {
    isDone = !isDone;
  }
}