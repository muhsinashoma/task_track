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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Task ---', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onUpdate(_controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update Task -----'),
            ),
          ],
        ),
      ),
    );
  }
}
