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
  int currentPageIndex = 0;
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
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.check_outlined), label: 'Todo'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Note'),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // account bar
              Container(
                height: 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Muhammad Azzuhry', //replace
                                style: TextStyle(
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
                        child: Container(
                          padding: EdgeInsets.all(
                              4), // Optional padding to give some space
                          child: CircleAvatar(
                            backgroundImage: null, // Use local image
                            radius: 24, // Adjust size as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // list
              Expanded(
                  child: ListView.builder(
                      itemCount: _todoItems.length,
                      itemBuilder: (context, index) {
                        final todoItem = _todoItems[index];
                        return TodoCard(index: index, todoItem: todoItem);
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('add'),
        icon: const Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
