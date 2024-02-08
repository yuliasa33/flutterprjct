import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test1/constant/colors.dart';
import 'package:test1/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          onTap: () => {onToDoChanged(todo)},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          tileColor: Colors.white,
          leading: IconButton(
            onPressed: () => {onToDoChanged(todo)},
            icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: tdBlue,
            ),
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 2),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: Icon(Icons.delete),
              iconSize: 18,
              onPressed: () => {onDeleteItem(todo.id)},
              color: Colors.white,
            ),
          ),
        ));
  }
}
