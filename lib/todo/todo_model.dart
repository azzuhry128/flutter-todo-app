// ignore_for_file: non_constant_identifier_names

class GetTodoModel {
  final String account_id;

  GetTodoModel({required this.account_id});

  Map<String, dynamic> toJson() {
    return {'account_id': account_id};
  }

  factory GetTodoModel.fromJson(Map<String, dynamic> json) {
    return GetTodoModel(
      account_id: json['account_id'],
    );
  }
}

class CreateTodoModel {
  final String title;
  final String description;

  CreateTodoModel({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }

  factory CreateTodoModel.fromJson(Map<String, dynamic> json) {
    return CreateTodoModel(
        title: json['title'], description: json['description']);
  }
}

class UpdateTodoModel {
  final String? title;
  final String? description;
  final bool? status;
  final String? dueDate;
  final String? priority;
  final List<String>? tags;

  UpdateTodoModel({
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.priority,
    this.tags,
  });

  factory UpdateTodoModel.fromJson(Map<String, dynamic> json) {
    return UpdateTodoModel(
      title: json['title'],
      description: json['description'],
      status: json['status'],
      dueDate: json['due_date'],
      priority: json['priority'],
      tags: (json['tags'] as List?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'due_date': dueDate,
      'priority': priority,
      'tags': tags,
    };
  }
}

class DeleteTodoModel {
  final String todo_id;

  DeleteTodoModel({
    required this.todo_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'todo_id': todo_id,
    };
  }

  factory DeleteTodoModel.fromJson(Map<String, dynamic> json) {
    return DeleteTodoModel(
      todo_id: json['todo_id'],
    );
  }
}

class TodoItemModel {
  String title;
  String description;
  bool status;

  TodoItemModel({
    required this.title,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'status': status};
  }
}
