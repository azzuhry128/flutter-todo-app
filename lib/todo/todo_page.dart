import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/widgets/todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItemModel> _todoItems = [];
  bool _isLoading = false;

  Future<void> _getTodosFromServer() async {
    setState(() {
      _isLoading = true;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todoItems[index].status = !_todoItems[index].status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          // REMOVE SingleChildScrollView
          itemCount: _todoItems.length,
          itemBuilder: (context, index) {
            final todoItem = _todoItems[index];
            return TodoCard(
              todoItem: todoItem,
              onDelete: () => _deleteTodoItem(index),
              onToggleDone: () => _toggleDone(index),
            );
          },
        ),
      ),
    );
  }
}
