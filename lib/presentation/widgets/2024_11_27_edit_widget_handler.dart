import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditItemPage(taskId: '12345'), // Example task ID
    );
  }
}

class EditItemPage extends StatefulWidget {
  final String taskId;

  const EditItemPage({required this.taskId});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listener to the focus node
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Focus lost
        editItemHandler(_controller.text, widget.taskId);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void editItemHandler(String title, String taskId) {
    print('-----------Working on Edit Function--------$title');
    print('-------------ID---------$taskId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item ${widget.taskId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Enter Title',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
