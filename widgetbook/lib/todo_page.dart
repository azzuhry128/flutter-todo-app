import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/todo/widgets/todo_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

@widgetbook.UseCase(name: 'Default', type: TodoPageMockup)
Widget buildCoolButtonUseCase(BuildContext context) {
  return TodoPageMockup();
}

class TodoPageMockup extends StatefulWidget {
  const TodoPageMockup({super.key});

  @override
  _TodoPageMockupState createState() => _TodoPageMockupState();
}

class _TodoPageMockupState extends State<TodoPageMockup> {
  final List<TodoItemModel> _todoItems = [
    TodoItemModel(
      todo_id: '1',
      title: 'Buy groceries',
      description: 'Milk, Eggs, Bread, Fruits',
      status: false,
    ),
    TodoItemModel(
      todo_id: '2',
      title: 'Walk the dog',
      description: 'Take Rex for a walk in the park',
      status: true,
    ),
    TodoItemModel(
      todo_id: '3',
      title: 'Read a book',
      description: 'Finish reading Flutter for Beginners',
      status: false,
    ),
    TodoItemModel(
      todo_id: '4',
      title: 'Workout',
      description: '30 minutes of cardio',
      status: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            accountBar(),
            const SizedBox(width: 16),
            todoList(),
          ],
        ),
      ),
      floatingActionButton: addTodoButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Expanded todoList() {
    return Expanded(
        child: ListView.builder(
            itemCount: _todoItems.length,
            itemBuilder: (context, index) {
              final todoItem = _todoItems[index];
              return TodoCard(
                index: index,
                todoItem: todoItem,
              );
            }));
  }
}

FloatingActionButton addTodoButton() {
  return FloatingActionButton.extended(
    onPressed: () {},
    label: const Text('add'),
    icon: const Icon(
      Icons.add,
      size: 24.0,
    ),
  );
}

Container accountBar() {
  return Container(
    height: 96,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: const CircleAvatar(
            radius: 32, // Adjust as needed
            backgroundColor: Colors.indigo,
          ),
        ),
        Flexible(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good morning!',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Muhammad Azzuhry', //replace
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              // Handle settings button press
              print('Settings button pressed');
            },
            icon: const Icon(
              Icons.settings,
              size: 28,
            ),
            color: Colors.indigo,
          ),
        ),
      ],
    ),
  );
}
