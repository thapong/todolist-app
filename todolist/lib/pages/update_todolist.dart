import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/globals.dart';
import 'package:todolist/pages/todolist.dart';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController todo_Titile = TextEditingController();
  TextEditingController todo_Detail = TextEditingController();
  var _v1, _v2, _v3;

  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    todo_Titile.text = _v2;
    todo_Detail.text = _v3;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist"),
        actions: [
          IconButton(
              onPressed: () {
                print("Delete ID: $_v1");
                deleteTodo();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Text('Todo List '),
                    TextField(
                        controller: todo_Titile,
                        decoration: InputDecoration(
                            labelText: 'Title :',
                            border: OutlineInputBorder())),
                    SizedBox(height: 20),
                    TextField(
                        controller: todo_Detail,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        decoration: InputDecoration(
                            labelText: 'Detail :',
                            border: OutlineInputBorder())),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          print('--------');
                          print('Title :${todo_Titile.text}');
                          print('Detail :${todo_Detail.text}');
                          updateTodo();
                          todo_Titile.clear();
                          todo_Detail.clear();
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(80, 20, 80, 20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          print('---Back---');

                          Navigator.pop(context);
                        },
                        child: Text("Back"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(80, 20, 80, 20))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    var url = Uri.http(rootUrl, '/api/update-todolist/$_v1');
    //var url = Uri.https('e4aa-49-49-217-113.ngrok.io', '/api/post-todolist');

    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_Titile.text}","detail":"${todo_Detail.text}" }';
    var response = await http.put(url, headers: header, body: jsondata);
    print('_____body________');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http(rootUrl, '/api/delete-todolist/$_v1');
    //var url = Uri.https('e4aa-49-49-217-113.ngrok.io', '/api/post-todolist');

    Map<String, String> header = {"Content-type": "application/json"};
    // String jsondata =
    //      '{"title":"${todo_Titile.text}","detail":"${todo_Detail.text}" }';
    var response = await http.delete(url, headers: header);
    print('______Result_______');
    print(response.body);
  }
}
