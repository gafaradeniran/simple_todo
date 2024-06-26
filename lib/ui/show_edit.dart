import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo/model/get_todo.dart';
import 'package:simple_todo/model/update_todo.dart';
import 'package:simple_todo/provider/provider.dart';
import 'package:simple_todo/utils/ui_state.dart';

void showEditTodo({
  required BuildContext context,
  required int id,
  required TodoItem item,
}) {
  showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return HookConsumer(
          builder: (context, ref, child) {
            final value = useState(item.completed);
            final controller = useTextEditingController(text: item.todo);
            final userId = item.userId;
            final updateId = id;

            ref.listen(todoProvider.select((state) => state.updateTodoState),
                (previous, next) {
              if (next.isSuccess) {
                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Todo updated')),
              );
              } else if (next.isError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error updating todo, pls try again"),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pop(context);
              }
            });
            final editState = ref
                .watch(todoProvider.select((state) => state.updateTodoState));
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit To-do',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Edit",
                          label: Text(controller.text),
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
                      const SizedBox(height: 20),
                      if (editState is UiStateLoading)
                        const Center(child: CircularProgressIndicator()),
                      // else if (editState is UiStateError)

                      Center(
                          child: MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        color: Colors.deepPurple,
                        onPressed: () {
                          ref.read(todoProvider.notifier).updateTodo(
                              updateId,
                              UpdateTodo(
                                id: updateId,
                                todo: controller.text,
                                completed: value.value,
                                userId: userId,
                              ));
                        },
                        child: const Text('Save'),
                      )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
