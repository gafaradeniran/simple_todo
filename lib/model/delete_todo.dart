
import 'package:json_annotation/json_annotation.dart';

part 'delete_todo.g.dart';

@JsonSerializable()
class DeleteTodo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;
  final bool isDeleted;
  final DateTime deletedOn;

  DeleteTodo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
    required this.isDeleted,
    required this.deletedOn,
  });

  factory DeleteTodo.fromJson(Map<String, dynamic> json) => _$DeleteTodoFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteTodoToJson(this);
}
