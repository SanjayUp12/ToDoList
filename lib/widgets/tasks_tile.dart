import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  TasksTile(
      {required this.taskTitle,
      required this.isChecked,
      required this.toggleCheckBoxState,
      required this.longPressCallback});
  final String taskTitle;
  bool isChecked = false;
  final void Function(bool?)? toggleCheckBoxState;
  final void Function() longPressCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        longPressCallback();
      },
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          toggleCheckBoxState!(value!);
        },
      ),
    );
  }
}
