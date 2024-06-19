// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteTodo _$DeleteTodoFromJson(Map<String, dynamic> json) => DeleteTodo(
      id: (json['id'] as num).toInt(),
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num).toInt(),
      isDeleted: json['isDeleted'] as bool,
      deletedOn: DateTime.parse(json['deletedOn'] as String),
    );

Map<String, dynamic> _$DeleteTodoToJson(DeleteTodo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
      'isDeleted': instance.isDeleted,
      'deletedOn': instance.deletedOn.toIso8601String(),
    };
