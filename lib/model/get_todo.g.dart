// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) => TodoItem(
      id: (json['id'] as num).toInt(),
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$TodoItemToJson(TodoItem instance) => <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };

GetTodos _$GetTodosFromJson(Map<String, dynamic> json) => GetTodos(
      todos: (json['todos'] as List<dynamic>)
          .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$GetTodosToJson(GetTodos instance) => <String, dynamic>{
      'todos': instance.todos,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
