import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/store/todo_store.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_service.dart';

final Logger todoCardLogger = Logger("TodoCard");

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

  void _showEditDialog(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: todoItem.title);
    final TextEditingController descriptionController =
        TextEditingController(text: todoItem.description);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    todoCardLogger.info('saving todo edits');
                    TodoStore().editTodo(todoItem.todo_id, titleController.text,
                        descriptionController.text);
                    TodoService.updateTodo(
                        UpdateTodoModel(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                        todoItem.todo_id);
                    Navigator.of(context).pop();
                  },
                  child: const Text('save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(todoItem.todo_id),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _showEditDialog(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16), // Add padding to the ListTitle
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Checkbox(
                  key: Key(todoItem.todo_id),
                  value: todoItem.status,
                  onChanged: (value) {
                    TodoStore().statusTodo(todoItem.todo_id);
                    TodoService.updateTodo(
                        UpdateTodoModel(
                          status: !todoItem.status,
                        ),
                        todoItem.todo_id);
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
                    TodoStore().deleteTodo(index);
                    TodoService.deletetodo(todoItem.todo_id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
