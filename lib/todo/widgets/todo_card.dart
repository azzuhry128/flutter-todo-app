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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the card
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // Shadow offset
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox to mark todo as done
          Checkbox(
            value: todoItem.status,
            onChanged: (value) => onToggleDone(),
            checkColor: Colors.white,
            activeColor: const Color(0xFF4294FF),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoItem.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: todoItem.status ? Colors.grey : Colors.black,
                    decoration: todoItem.status
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  todoItem.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontFamily: 'Sans',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.fade, // Use fade instead of ellipsis
                )
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDelete,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
