import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:simple_todo/model/delete_todo.dart';
import 'package:simple_todo/model/get_todo.dart';
import 'package:simple_todo/provider/provider.dart';
import 'package:simple_todo/ui/add_todos.dart';
import 'package:simple_todo/ui/show_delete.dart';
import 'package:simple_todo/ui/show_edit.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final controller =
        useMemoized(() => ref.read(todoProvider.notifier).getTodoController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddTodo()));
        },
        child: const Icon(Icons.add, size: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchBar(
                  controller: searchController,
                  hintText: "Search todos",
                  onChanged: (value) {},

                  // elevation: 0,
                  leading: const Icon(Icons.search),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: RefreshIndicator(
                      onRefresh: () async {
                        controller.refresh();
                      },
                      child: PagedListView.separated(
                        pagingController: controller,
                        builderDelegate: PagedChildBuilderDelegate<TodoItem>(
                          itemBuilder: (context, item, index) => TodoContainer(
                            item: item,
                          ),
                          firstPageProgressIndicatorBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          firstPageErrorIndicatorBuilder: (context) =>
                              const Center(
                            child: Text('Something went wrong!'),
                          ),
                          noItemsFoundIndicatorBuilder: (context) =>
                              const Center(
                            child: Text('No items found'),
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 15),
                      )),
                )
              ],
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
  const TodoContainer({super.key, required this.item, this.deleteTodo});

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
                  icon: const Icon(Icons.edit)),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: () {
                    showDeleteDialog(context: context, id: item.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
          if (deleteTodo?.isDeleted ?? false)
            const Text(
              'Todo already deleted',
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}
