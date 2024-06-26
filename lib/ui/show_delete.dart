import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo/provider/provider.dart';
import 'package:simple_todo/utils/ui_state.dart';

void showDeleteDialog({
  required BuildContext context,
  required int id,
  required VoidCallback onDelete,
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
          ref.listen(todoProvider.select((state) => state.deleteTodoState),
              (previous, next) {
            if (next.isSuccess) {
              Navigator.pop(context);
            } else if (next.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("An Error occoured, try again"),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pop(context);
            }
          });

          final deleteState =
              ref.watch(todoProvider.select((state) => state.deleteTodoState));

          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Delete Todo Item",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: Text(
                      "Are you sure you want to delete this todo item?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (deleteState is UiStateLoading)
                    const CircularProgressIndicator()
                  else if (deleteState is UiStateError)
                    Text(
                      deleteState.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.grey,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Consumer(builder: (context, ref, child) {
                          return MaterialButton(
                            onPressed: () {
                              onDelete();
                            },
                            elevation: 0,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.red,
                            child: const Text(
                              "Proceed",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
