import 'package:flutter/material.dart';
import 'package:todo_list/examples.dart';
import 'package:todo_list/required/colors.dart';

class Items extends StatelessWidget {
  final ToDo todo;
  final taskChanges;
  final deleteTask;
  const Items({
    super.key,
    required this.todo,
    required this.taskChanges,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          taskChanges(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tcBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tcBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tcRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteTask(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
