import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo/model/new_todo.dart';
import 'package:simple_todo/provider/provider.dart';
import 'package:simple_todo/utils/ui_state.dart';

class AddTodos extends HookConsumerWidget {
  final AddTodo? todoItems;
  const AddTodos(this.todoItems, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: todoItems?.todo ?? '');
    final value = useState(todoItems?.completed ?? false);
    final userId = todoItems?.userId ?? 1;
    final id = todoItems?.id ?? 0;

    final notifier = ref.read(todoProvider.notifier);
    var listenable = todoProvider.select((value) => value.createTodoState);

    ref.listen(listenable, (previous, next) {
      if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An Error occoured, try again"),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      }
      if (next.isLoading) {
        const Center(child: CircularProgressIndicator());
      }
      if (next.isSuccess) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Todo successfully added',
                style: TextStyle(color: Colors.green))));
      }
    });
    final addTodoState =
        ref.watch(todoProvider.select((state) => state.createTodoState));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Write To-do'),
            const SizedBox(height: 15),
            TextFormField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "New todo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('I have accomplished this to-do '),
                Checkbox(
                  value: value.value,
                  onChanged: (newValue) {
                    value.value = newValue ?? false;
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            if (addTodoState is UiStateLoading)
              const Center(child: CircularProgressIndicator())
            else if (addTodoState is UiStateError)
              const Center(
                child: Text(
                  "Error adding todo, pls try again",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Center(
                child: MaterialButton(
              minWidth: double.infinity,
              height: 40,
              color: Colors.deepPurple,
              onPressed: () {
                final todos = AddTodo(
                  id: id,
                  todo: controller.text,
                  completed: value.value,
                  userId: userId,
                );
                notifier.createTodo(request: todos);
              },
              child: const Text('Save'),
            )),
          ],
        ),
      ),
    );
  }
}
