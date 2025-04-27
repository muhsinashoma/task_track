import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditItemPage extends StatefulWidget {
  final String taskId;
  final String taskTitle;

  const EditItemPage({required this.taskId, required this.taskTitle});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? updatedAt;
  String? updatedBy;

  Future<void> fetchTaskById(String taskId) async {
    String taskTitle = widget.taskTitle;
    _controller.text = taskTitle;
  }

  @override
  void initState() {
    _controller.text = widget.taskTitle;
    super.initState();

    fetchTaskById(widget.taskId);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
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

  Future<void> editItemHandler(String textTitle, String taskId) async {
    print("Edited item with task ID: $taskId and New text: $textTitle");

    setState(() {
      updatedAt = DateTime.now().toString();
      updatedBy = 'Muhsina';
      print('Update Date: $updatedAt');
      print('Updated By: $updatedBy');
    });

    final dio = Dio();
    var url = "http://192.168.33.69/API/update_task_kanban.php";

    try {
      var responseData = {
        "id": taskId,
        "title": textTitle,
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

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Show success message after successful update
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Task Successfully Updated!'),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        // Show error message if response status code is not 200
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update task. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } catch (e) {
      print('Error occurred: $e');

      // Show error message in case of an exception
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update task. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  void handleSubmit() {
    if (_controller.text.isEmpty) {
      // Show validation message if title is empty
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task title cannot be empty'),
            backgroundColor: Colors.red,
          ),
        );
      });
    } else {
      // Proceed with the update if valid
      print('Submitting task...');
      editItemHandler(_controller.text, widget.taskId).then((_) {
        // After editing is done, pop the updated title back to the previous page
        Navigator.pop(context, _controller.text); // Send back updated title
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item ${widget.taskId}'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                prefix: SizedBox(
                  width: 30.0,
                  height: 50.0,
                ),
                label: Row(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Enter Task Title',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 231, 94, 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Title: ${_controller.text}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Updated At: ${updatedAt ?? 'Not updated yet'}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Updated By: ${updatedBy ?? 'Not updated yet'}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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
