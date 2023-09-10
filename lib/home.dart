import 'package:flutter/material.dart';
import 'package:todo_list/examples.dart';
import 'package:todo_list/items.dart';
import 'package:todo_list/required/colors.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoitems = ToDo.todoList();
  final _taskManager = TextEditingController();
  List<ToDo> _searchTodo = [];

  @override
  void initState() {
    // TODO: implement initState
    _searchTodo = todoitems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tcWhite,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            'Tasks',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      for (ToDo task in _searchTodo)
                        Items(
                          todo: task,
                          taskChanges: _changes,
                          deleteTask: _delete,
                        ), //todo - from items file
                    ],
                  ))
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _taskManager,
                    decoration: InputDecoration(
                        hintText: 'Add a new task', border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    //get text provided by user.
                    _add(_taskManager.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tcBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

//creating and calling functions so that the buttons work.
  void _changes(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _delete(String id) {
    setState(() {
      todoitems.removeWhere((item) => item.id == id);
    });
  }

  void _add(String task) {
    setState(() {
      //take id as current time then convert to millisec thn to string as there should be a unique id
      todoitems.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: task));
    });
    //to clear the text box after adding the task
    _taskManager.clear();
  }

  void _searchTask(String keyword) {
    List<ToDo> result = [];
    if (keyword.isEmpty) {
      result = todoitems;
    } else {
      result = todoitems
          .where((item) =>
              item.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _searchTodo = result;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tcWhite,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tcBlack,
          size: 30,
        ),
        Icon(
          Icons.check,
          color: tcBlack,
          size: 30,
        )
      ]),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _searchTask(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tcBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tcGrey),
        ),
      ),
    );
  }
}
