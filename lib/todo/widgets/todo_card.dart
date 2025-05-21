import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoItemModel todoItem;
  final VoidCallback onDelete;
  final VoidCallback onToggleDone;

  const TodoCard({
    super.key,
    required this.todoItem,
    required this.onDelete,
    required this.onToggleDone,
  });

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(todoItem.todo_id),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16), // Add padding to the ListTitle
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Checkbox(
                value: todoItem.status,
                onChanged: (value) {
                  // Call the _toggleDone method
                  _toggleDone(index);
                },
              ),
            ),
            Flexible(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoItem.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(todoItem.description),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Call the _deleteTodoItem method
                  _deleteTodoItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTodoItem(index) {}

  void _toggleDone(index) {}
}
