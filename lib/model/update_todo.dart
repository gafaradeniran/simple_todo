import 'package:json_annotation/json_annotation.dart';

part 'update_todo.g.dart';

@JsonSerializable()
class UpdateTodo {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'todo')
  final String todo;

  @JsonKey(name: 'completed')
  final bool completed;

  @JsonKey(name: 'userId')
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
