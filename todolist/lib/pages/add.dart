import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/globals.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  TextEditingController todo_Titile = TextEditingController();
  TextEditingController todo_Detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todolist"),
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
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          print('--------');
                          print('Title :${todo_Titile.text}');
                          print('Detail :${todo_Detail.text}');
                          postTodo();
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    var url = Uri.https(rootUrl, '/api/post-todolist');
    //var url = Uri.https('e4aa-49-49-217-113.ngrok.io', '/api/post-todolist');

    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_Titile.text}","detail":"${todo_Detail.text}" }';
    var response = await http.post(url, headers: header, body: jsondata);
    print('_____________');
    print(response.body);
  }
}
