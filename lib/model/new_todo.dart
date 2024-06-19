
import 'package:json_annotation/json_annotation.dart';

part 'new_todo.g.dart';

@JsonSerializable()
class AddTodo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  AddTodo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory AddTodo.fromJson(Map<String, dynamic> json) => _$AddTodoFromJson(json);
  Map<String, dynamic> toJson() => _$AddTodoToJson(this);
}
