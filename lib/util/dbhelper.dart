import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lets_do_it/models/task.dart';

class DbHelpher {
  final int version = 1;
  Database? db;
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'todo.db'),
          onCreate: (database, version) {
        database.execute('CREATE TABLE todolist (task Text)');
      }, version: version);
    }
    return db!;
  }

  Future<List<Task>> showDB() async {
    db = await openDb();

    List<Map<String, dynamic>> result = await db!.query('todolist');

    List<Task> taskList = result.map((map) {
      return Task(isDone: false, name: map['task']);
    }).toList();

    return taskList;
  }

  Future insertDb(String item) async {
    db = await openDb();
    await db!.execute('Insert into todolist values("$item")');
  }

  Future deleteDb(String item) async {
    db = await openDb();
    await db!.execute('Delete from todolist where task="$item"');
  }
}
