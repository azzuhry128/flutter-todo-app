import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/widgets/todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItemModel> _todoItems = [
    TodoItemModel(
        title: 'Buy Groceries',
        description: 'Milk, bread, eggs',
        status: false),
    TodoItemModel(
        title: 'Pay Bills', description: 'Rent, utilities', status: false),
    TodoItemModel(
        title: 'Walk the Dog', description: 'Around the park', status: false),
    TodoItemModel(
        title: 'Write Report', description: 'For the meeting', status: false),
    TodoItemModel(title: 'Call Mom', description: 'To wish her', status: false),
  ];
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
        child: Column(
          children: [
            accountBar(),
            const SizedBox(width: 16),
            Expanded(
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
          ],
        ),
      ),
      floatingActionButton: addTodoButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

FloatingActionButton addTodoButton(BuildContext context) {
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
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/100'), // Replace with your image URL
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
