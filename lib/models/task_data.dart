import 'dart:collection';
import 'package:lets_do_it/util/dbhelper.dart';
import 'package:flutter/foundation.dart';
import 'package:lets_do_it/models/task.dart';

class TaskData extends ChangeNotifier {
  DbHelpher helpher = DbHelpher();
  late List<Task> _tasks = [];

  Future<void> initializeTasks() async {
    List<Task> fetchedTasks = await helpher.showDB();
    _tasks = fetchedTasks;
    notifyListeners();
  }

  Future<void> fetchDataAndStoreTasks() async {
    // notifyListeners();
    await initializeTasks();
  }

  UnmodifiableListView<Task> get tasks {
    if (_tasks.isEmpty) {
      fetchDataAndStoreTasks();
    }
    return UnmodifiableListView(_tasks);
  }

  void add(String newTaskTitle) {
    final newTask = Task(name: newTaskTitle, isDone: false);
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.isDoneToggle();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
