import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTodo extends HookConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final value = useState(false);

    
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
          ],
        ),
      ),
    );
  }
}
