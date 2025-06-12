import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/store/todo_store.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_service.dart';

final Logger todoCardLogger = Logger("TodoCard");

class TodoCard extends StatelessWidget {
  final int index;
  final TodoItemModel todoItem;

  const TodoCard({
    super.key,
    required this.index,
    required this.todoItem,
  });

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
            content: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      maxLines: 3,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      expands: false,
                      style: TextStyle(overflow: TextOverflow.visible),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      expands: false,
                      style: TextStyle(overflow: TextOverflow.visible),
                    )
                  ],
                ),
              ),
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

  void _deleteDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('This action cannot be undone'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    todoCardLogger.info('cancelling delete');
                    Navigator.of(context).pop();
                  },
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () {
                    todoCardLogger.info('deleting todo');
                    TodoStore().deleteTodo(index);
                    TodoService.deletetodo(todoItem.todo_id);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    'delete',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ))
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
                    TodoService.updateTodo(
                        UpdateTodoModel(
                          status: !todoItem.status,
                        ),
                        todoItem.todo_id);
                    TodoStore().statusTodo(todoItem.todo_id);
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
                  key: Key(todoItem.todo_id),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    _deleteDialogue(context);
                    todoCardLogger.info('deleted index: $index');
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
