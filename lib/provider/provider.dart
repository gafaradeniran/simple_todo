import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo/core/di.dart';
import 'package:simple_todo/data/api_services.dart';
import 'package:simple_todo/model/get_todo.dart';
import 'package:simple_todo/model/new_todo.dart';
import 'package:simple_todo/model/update_todo.dart';
import 'package:simple_todo/utils/ui_state.dart';

final todoProvider =
    StateNotifierProvider.autoDispose<TodoNotifier, TodoState>((ref) {
  return TodoNotifier(ref);
});
final searchQueryProvider = StateProvider<String>((ref) => '');

class TodoNotifier extends StateNotifier<TodoState> {
  TodoNotifier(this.ref) : super(const TodoState());
  final Ref ref;
  final _apiService = TodoApiServices(getIt.get());

  Future<void> getAllTodos() async {
    try {
      state = state.copyWith(getTodoState: const UiState.loading());
      final response = await _apiService.getTodos();
      state = state.copyWith(
          getTodoState: UiState.success(response), todos: response.todos);
    } catch (e) {
      state = state.copyWith(getTodoState: UiState.error(e.toString()));
    }
  }
  Future<void> createTodo({required AddTodo request}) async {
  try {
    state = state.copyWith(createTodoState: const UiState.loading());
    await _apiService.createCoupon(request);
    // Generate a unique ID for the new todo item
    final newId = state.todos.isNotEmpty ? state.todos.last.id + 1 : 1;
    final newTodo = TodoItem(
      id: newId,
      todo: request.todo,
      completed: request.completed,
      userId: request.userId,
    );
    // Add the new todo to the local state
    final updatedTodos = List<TodoItem>.from(state.todos)..add(newTodo);
    state = state.copyWith(
      createTodoState: const UiState.success(null),
      todos: updatedTodos,
    );
  } catch (e) {
    state = state.copyWith(createTodoState: UiState.error(e.toString()));
  }
}

  // Future<void> createTodo({required AddTodo request}) async {
  //   try {
  //     state = state.copyWith(createTodoState: const UiState.loading());
  //     final response = await _apiService.createCoupon(request);
  //     state = state.copyWith(createTodoState: UiState.success(response));
  //   } catch (e) {
  //     state = state.copyWith(createTodoState: UiState.error(e.toString()));
  //   }
  // }


  void updateTodo(int id, UpdateTodo updateTodo) async {
    try {
      state = state.copyWith(updateTodoState: const UiState.loading());
      final response = await _apiService.updateTodo(id, updateTodo);
      final updatedTodos = state.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(
              todo: updateTodo.todo, completed: updateTodo.completed);
        }
        return todo;
      }).toList();
      state = state.copyWith(
          updateTodoState: UiState.success(response), todos: updatedTodos);
      state = state.copyWith(updateTodoState: UiState.success(response));
    } catch (e) {
      state = state.copyWith(updateTodoState: UiState.error(e.toString()));
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      state = state.copyWith(deleteTodoState: const UiState.loading());
      final response = await _apiService.deleteTodo(id);
      final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
      state = state.copyWith(
          deleteTodoState: UiState.success(response), todos: updatedTodos);
    } catch (e) {
      state = state.copyWith(deleteTodoState: UiState.error(e.toString()));
    }
  }
}

class TodoState {
  final UiState<dynamic> getTodoState;
  final UiState<dynamic> createTodoState;
  final UiState<dynamic> updateTodoState;
  final UiState<dynamic> deleteTodoState;
  final List<TodoItem> todos;

  const TodoState({
    this.getTodoState = const UiStateInitial(),
    this.createTodoState = const UiStateInitial(),
    this.updateTodoState = const UiStateInitial(),
    this.deleteTodoState = const UiStateInitial(),
    this.todos = const [],
  });

  TodoState copyWith({
    UiState<dynamic>? getTodoState,
    UiState<dynamic>? createTodoState,
    UiState<dynamic>? updateTodoState,
    UiState<dynamic>? deleteTodoState,
    List<TodoItem>? todos,
  }) {
    return TodoState(
      getTodoState: getTodoState ?? this.getTodoState,
      createTodoState: createTodoState ?? this.createTodoState,
      updateTodoState: updateTodoState ?? this.updateTodoState,
      deleteTodoState: deleteTodoState ?? this.deleteTodoState,
      todos: todos ?? this.todos,
    );
  }
}
