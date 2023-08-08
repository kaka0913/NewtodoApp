import 'package:flutter/material.dart';
import 'package:mytodo_app/todo_add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);
  @override
  TodoListPageState createState() => TodoListPageState();
}


class TodoListPageState extends State<TodoListPage> {
  //todoリストのデータ保存用
  List<String> todoList = [];
  //todoの結果保存用
  //List<bool> isDoFlg = [];
  Map<String, bool> isDoFlg = {};
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoリスト一覧'),
      ),
      //body: Container(),
      
      body: ReorderableListView.builder(
        itemCount: todoList.isEmpty ? 0 : todoList.length,
        itemBuilder: (context, index) {
           if (todoList.isEmpty) {
            return SizedBox.shrink(); // 空のWidgetを返すことで表示されないようにする
          }
          return Card(
            key: Key(index.toString()),
            child: ListTile(
              leading: Checkbox(
                value: isDoFlg[todoList[index]] ?? false,
                onChanged: (value) {
                  setState(() {
                    isDoFlg[todoList[index]]=value!;
                  });
              },
            ),
            title: Text(todoList[index]),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  todoList.removeAt(index);
                  isDoFlg.remove(todoList[index]);
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left : 10.0,
                  top : 10.0,
                  right : 10.0,
                  bottom : 10.0,
                ),
                child: Text("削除", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        );
        },
        //要素移動のUI
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
            final String item = todoList.removeAt(oldIndex);
            final isDo = isDoFlg.remove(item);
            setState(() {
            todoList.insert(newIndex, item);
            //isDoFlg.insert(newIndex, isDo);
            isDoFlg[item] = isDo!;
          });
          
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              todoList.add(newListText);
              isDoFlg[newListText] = false; // isDoFlgリストにも要素を追加する
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}