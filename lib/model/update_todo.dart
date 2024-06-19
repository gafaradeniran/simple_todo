import 'package:json_annotation/json_annotation.dart';

part 'update_todo.g.dart';

@JsonSerializable()
class UpdateTodo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  UpdateTodo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory UpdateTodo.fromJson(Map<String, dynamic> json) => _$UpdateTodoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateTodoToJson(this);
}
