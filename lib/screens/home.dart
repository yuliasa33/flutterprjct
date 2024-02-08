import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test1/constant/colors.dart';
import 'package:test1/model/todo.dart';

import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.toDoList();

  List<ToDo> FoundToDo = [];

  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    FoundToDo = todoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        "All To Do's ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todoo in FoundToDo.reversed)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _onDeletItem,
                      )
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: "Add new To Do", border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _AddItemToDo(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(50, 50),
                        elevation: 10),
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleCariTodoList(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      FoundToDo = results;
    });
  }

  void _handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _onDeletItem(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _AddItemToDo(String toDoo) {
    setState(() {
      todoList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDoo,
        ),
      );
      print(toDoo);
    });

    _todoController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => handleCariTodoList(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey)),
      ), //box search harus diberi textfield biar ke render
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0, //untuk menghilangkan border bayangan dibawah app bar
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // memberi jarak pada 2 konten bar menu dan PP user
        children: [
          IconButton(
            onPressed: () => {print("Ini Side bar nya")},
            icon: Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child:
                  Image.asset("../assets/images/neutral.png"), //mengakses image
            ),
          )
        ],
      ),
    );
  }
}
