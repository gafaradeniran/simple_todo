// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTodo _$AddTodoFromJson(Map<String, dynamic> json) => AddTodo(
      id: (json['id'] as num).toInt(),
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$AddTodoToJson(AddTodo instance) => <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };
