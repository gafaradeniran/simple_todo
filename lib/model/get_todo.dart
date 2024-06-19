import 'package:json_annotation/json_annotation.dart';

part 'get_todo.g.dart';

@JsonSerializable()
class TodoItem {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoItem({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
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
