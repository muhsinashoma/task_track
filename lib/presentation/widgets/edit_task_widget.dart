import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'button_widget.dart';

class EditTaskForm extends StatefulWidget {
  final KTask task;
  final void Function(String title) onUpdate;

  const EditTaskForm({
    super.key,
    required this.task,
    required this.onUpdate,
  });

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // TextField(
              //   controller: _controller,
              //   decoration: InputDecoration(
              //     labelText: 'Task Title',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),

              TextField(
                controller: _controller,
                maxLines: null, // Allows unlimited lines
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // onPressed: () {
                //   widget.onUpdate(_controller.text);
                //   Navigator.of(context).pop();
                // },

                // onPressed: () {
                //   final text = _controller.text.trim();
                //   if (text.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Task cannot be empty')),
                //     );
                //     return;
                //   }

                //   widget.onUpdate(text);
                //   Navigator.of(context).pop();
                // },

                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task title cannot be empty'),
                      ),
                    );
                    return;
                  }

                  widget.onUpdate(text);
                  Navigator.of(context).pop();

                  // Show success SnackBar with green color
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Task updated successfully!'),
                      backgroundColor:
                          Colors.green, // Set the background color to green
                    ),
                  );
                },

                icon: const Icon(Icons.save),
                label: const Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
