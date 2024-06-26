import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo/model/delete_todo.dart';
import 'package:simple_todo/model/get_todo.dart';
import 'package:simple_todo/model/new_todo.dart';
import 'package:simple_todo/provider/provider.dart';
import 'package:simple_todo/ui/add_todos.dart';
import 'package:simple_todo/ui/show_delete.dart';
import 'package:simple_todo/ui/show_edit.dart';
import 'package:simple_todo/utils/ui_state.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AddTodo? todoItems;
    final searchController = useTextEditingController();
    final searchQuery = ref.watch(searchQueryProvider);
    final todos = ref.watch(todoProvider.select((state) => state.todos));
    final todoNotifier = ref.read(todoProvider.notifier);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        todoNotifier.getAllTodos();
      });
      return;
    }, []);
    final todoState =
        ref.watch(todoProvider.select((state) => state.getTodoState));

    final filteredTodos = todos
        .where((todo) =>
            todo.todo.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTodos(todoItems)));
        },
        child: const Icon(Icons.add, size: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
              hintText: "Search todos",
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              leading: const Icon(Icons.search),
            ),
            const SizedBox(height: 16),
            if (todoState is UiStateLoading)
              const Center(child: CircularProgressIndicator())
            else if (todoState is UiStateError)
              const Center(
                child: Text(
                  "Error loading data, pls refresh",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await todoNotifier.getAllTodos();
                },
                child: ListView.separated(
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    final item = filteredTodos[index];
                    return TodoContainer(
                      item: item,
                      onDelete: () {
                        ref.read(todoProvider.notifier).deleteTodo(item.id);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoContainer extends StatelessWidget {
  final TodoItem item;
  final DeleteTodo? deleteTodo;
  final VoidCallback onDelete;
  const TodoContainer(
      {super.key, required this.item, this.deleteTodo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.todo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
          Row(
            children: [
              item.completed
                  ? const Text(
                      "Task completed",
                      style: TextStyle(color: Colors.green),
                    )
                  : const Text(
                      "Task pending",
                      style: TextStyle(color: Colors.red),
                    ),
              const Expanded(child: SizedBox(width: 5)),
              IconButton(
                onPressed: () {
                  showEditTodo(context: context, id: item.id, item: item);
                },
                icon: const Icon(Icons.edit),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  showDeleteDialog(
                      context: context, id: item.id, onDelete: onDelete);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
