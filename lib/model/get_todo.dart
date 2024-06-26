import 'package:json_annotation/json_annotation.dart';

part 'get_todo.g.dart';

@JsonSerializable()
class TodoItem {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isDeleted;
  final DateTime? deletedOn;

  TodoItem({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    this.isDeleted = false,
    this.deletedOn,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  TodoItem copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
    bool? isDeleted,
    DateTime? deletedOn,
  }) {
    return TodoItem(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedOn: deletedOn ?? this.deletedOn,
    );
  }
}

@JsonSerializable()
class GetTodos {
  final List<TodoItem> todos;
  final int total;
  final int skip;
  final int limit;

  GetTodos({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory GetTodos.fromJson(Map<String, dynamic> json) =>
      _$GetTodosFromJson(json);
  Map<String, dynamic> toJson() => _$GetTodosToJson(this);
}
