import 'package:flutter/material.dart';
import 'package:mytodo_app/todo_list_page.dart';


void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // 右上に表示される"debug"ラベルを消す
        debugShowCheckedModeBanner: false,
        //アプリ名
        title: 'My Todo App',
        theme: ThemeData(
          //テーマカラー
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //リスト一覧画面を表示
        home: TodoListPage(),
      );
  }
}










