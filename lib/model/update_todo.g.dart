// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTodo _$UpdateTodoFromJson(Map<String, dynamic> json) => UpdateTodo(
      id: (json['id'] as num).toInt(),
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateTodoToJson(UpdateTodo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };
