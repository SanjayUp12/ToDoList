import 'package:flutter/material.dart';
import 'package:lets_do_it/util/dbhelper.dart';
import 'package:lets_do_it/widgets/tasks_tile.dart';
import 'package:provider/provider.dart';
import 'package:lets_do_it/models/task_data.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TasksTile(
          taskTitle: Provider.of<TaskData>(context).tasks[index].name,
          isChecked: Provider.of<TaskData>(context).tasks[index].isDone,
          toggleCheckBoxState: (bool? checkBoxState) {
            Provider.of<TaskData>(context, listen: false).updateTask(
                Provider.of<TaskData>(context, listen: false).tasks[index]);
          },
          longPressCallback: () async {
            final taskName = Provider.of<TaskData>(context, listen: false)
                .tasks[index]
                .name
                .toString();
            Provider.of<TaskData>(context, listen: false).deleteTask(
                Provider.of<TaskData>(context, listen: false).tasks[index]);
            DbHelpher helpher = DbHelpher();
            await helpher.deleteDb(taskName);
          },
        );
      },
      itemCount: Provider.of<TaskData>(context).tasks.length,
    );
  }
}
