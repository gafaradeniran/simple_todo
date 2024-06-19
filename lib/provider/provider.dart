import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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

class TodoNotifier extends StateNotifier<TodoState> {
  TodoNotifier(this.ref) : super(const TodoState());
  final Ref ref;
  final _apiService = TodoApiServices(getIt.get());
  PagingController<int, TodoItem> getTodoController() {
    var controller = PagingController<int, TodoItem>(firstPageKey: 1);
    controller.addPageRequestListener((pageKey) async {
      try {
        // var limit = 30;
        final response = await _apiService.getTodos(
            // pageKey,
            // limit
            );
        var todos = response.todos;
        if (todos.length < 20) {
          controller.appendLastPage(todos);
        } else {
          controller.appendPage(todos, pageKey + 1);
        }
      } catch (e) {
        controller.error(e);
      }
    });
    return controller;
  }

  Future<void> createTodo({required AddTodo request}) async {
    try {
      state = state.copyWith(createTodoState: const UiState.loading());
      final response = await _apiService.createCoupon(request);
      state = state.copyWith(createTodoState: UiState.success(response));
    } catch (e) {
      state = state.copyWith(createTodoState: UiState.error((e).toString()));
    }
  }

  void updateCoupon(int id, UpdateTodo updateTodo) async {
    try {
      state = state.copyWith(updateTodoState: const UiState.loading());
      final response = await _apiService.updateTodo(id, updateTodo);
      state = state.copyWith(updateTodoState: UiState.success(response));
    } catch (e) {
      state = state.copyWith(updateTodoState: UiState.error((e).toString()));
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      state = state.copyWith(deleteTodoState: const UiState.loading());
      final response = await _apiService.deleteTodo(id);
      state = state.copyWith(deleteTodoState: UiState.success(response));
      final controller = getTodoController();
      controller.refresh();
    } catch (e) {
      state = state.copyWith(deleteTodoState: UiState.error(e.toString()));
    }
  }
}

class TodoState {
  final UiState<dynamic> createTodoState;
  final UiState<dynamic> updateTodoState;
  final UiState<dynamic> deleteTodoState;

  const TodoState({
    this.createTodoState = const UiStateInitial(),
    this.updateTodoState = const UiStateInitial(),
    this.deleteTodoState = const UiStateInitial(),
  });

  TodoState copyWith({
    UiState<dynamic>? createTodoState,
    UiState<dynamic>? updateTodoState,
    UiState<dynamic>? deleteTodoState,
  }) {
    return TodoState(
      createTodoState: createTodoState ?? this.createTodoState,
      updateTodoState: updateTodoState ?? this.updateTodoState,
      deleteTodoState: deleteTodoState ?? this.deleteTodoState,
    );
  }
}
