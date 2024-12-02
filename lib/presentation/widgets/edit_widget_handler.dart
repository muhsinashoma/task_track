// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditItemPage(
          taskId: '12345',
          taskTitle: 'Sample Task Title'), // Pass both taskId and taskTitle
    );
  }
}

class EditItemPage extends StatefulWidget {
  final String taskId;
  final String taskTitle; // Add taskTitle as a parameter

  // Correct constructor definition with named parameters
  const EditItemPage({required this.taskId, required this.taskTitle});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? updatedAt;
  String? updatedBy;

  // Simulate a task database or API fetch by taskId
  Future<void> fetchTaskById(String taskId) async {
    // Simulate fetching task data (e.g., from an API or database)
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    // Here, you can use the `taskId` to get actual task data
    String taskTitle = widget.taskTitle; // Use taskTitle passed in constructor

    print('Fetched task title: $taskTitle');

    // Populate the TextField with the fetched title
    _controller.text = taskTitle;
  }

  @override
  void initState() {
    super.initState();

    // Fetch the task data when the page is initialized
    fetchTaskById(widget.taskId);

    // Add listener to the focus node to detect when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Focus lost, fetch the title value and handle the task edit
        print('Title: ${_controller.text}');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> editItemHandler(String text, String taskId) async {
    // Handle the edit item logic here (e.g., send updated data to an API)
    print("Edited item with task ID: $taskId and new text: $text");

    setState(() {
      updatedAt = DateTime.now().toString();
      updatedBy = 'Muhsina'; // Replace with the actual user information

      print('Update Date : $updatedAt');
      print('Updated By : $updatedBy');
    });

    // Here, you can update your database or API with the new data
    final dio = Dio();
    var url = "http://192.168.34.99/API/update_task_kanban.php";

    print(url);

    try {
      var responseData = {
        "id": taskId,
        "title": text,
        "edited_by": updatedBy,
        "edited_at": updatedAt
      };

      print('----------------Edited Data-----------------');
      print(responseData);

      Response response = await dio.post(
        url,
        data: responseData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
    } catch (e) {
      print('Unexpected Error : {$e}');
    }
  }

  void handleSubmit() {
    editItemHandler(_controller.text, widget.taskId);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying TextField for user input
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Enter Task Title',
                labelStyle: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            // Display the title value fetched from the controller
            Text(
              'Title: ${_controller.text}',
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            // Display the updatedAt value
            Text(
              'Updated At: ${updatedAt ?? 'Not updated yet'}',
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 10),
            // Display the updatedBy value
            Text(
              'Updated By: ${updatedBy ?? 'Not updated yet'}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add the submit button
            ElevatedButton(
              onPressed: handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
