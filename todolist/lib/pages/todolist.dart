import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:todolist/globals.dart';

import 'package:todolist/pages/update_todolist.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todolistitems = [];
  @override
  void initState() {
    super.initState();
    getTodolist();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todolist'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTodolist();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AppPage()))
              .then((value) {
            setState(() {
              getTodolist();
            });
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.task),
              title: Text("${todolistitems[index]['title']}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                            todolistitems[index]['id'],
                            todolistitems[index]['title'],
                            todolistitems[index]['detail']))).then((value) {
                  setState(() {
                    getTodolist();
                  });
                });
              },
            ),
          );
        });
  }

  Future<void> getTodolist() async {
    List alltodo = [];
    var url = Uri.https(rootUrl, '/api/all-todolist/');
    //var url = Uri.https('e4aa-49-49-217-113.ngrok.io', '/api/post-todolist');

    //  Map<String, String> header = {"Content-type": "application/json"};
    //  String jsondata =
    //      '{"title":"${todo_Titile.text}","detail":"${todo_Detail.text}" }';
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);

    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
