import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets/edit_task_widget.dart';
import '../widgets/kanban_board.dart';
import 'kanban_board_controller.dart';
import 'package:uuid/uuid.dart';

class KanbanSetStatePage extends StatefulWidget {
  const KanbanSetStatePage({super.key});

  @override
  _KanbanSetStatePageState createState() => _KanbanSetStatePageState();
}

class _KanbanSetStatePageState extends State<KanbanSetStatePage>
    implements KanbanBoardController {
  //To show column data

  List<KColumn> columns = [];

  @override
  void initState() {
    super.initState();
    getColumnData();
    getTaskData();
  }

  getColumnData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.22.217/API/get_column_data_kanban.php");

      columns = Data.getColumns(response.data); //print(columns);

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  getTaskData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.22.217/API/get_task_data_kanban.php");
      // print(response);

      if (response.statusCode == 200) {
        var taskData = response.data['task_boards'] as List; // print(taskData);

        List<Map<String, dynamic>> tasksForColumns = [];

        for (var board in taskData) {
          var tasks = board['tasks'] as List;

          // tasksForColumns.add({
          //   'id': int.tryParse(board['id'].toString()) ??
          //       0, // Ensure it's an integer
          //   'title': board['title'],
          //   'tasks': tasks
          //       .map((task) => {
          //             'id': int.tryParse(task['id'].toString()) ??
          //                 0, // Ensure task id is an integer
          //             'title': task['title']
          //           })
          //       .toList()
          // });

          tasksForColumns.add({
            'id': int.tryParse(board['id'].toString()) ?? 0,
            'title': board['title'],
            'tasks': tasks
                .map((task) => {
                      'id': int.tryParse(task['id'].toString()) ?? 0,
                      'title': task['title'],
                      'taskId': task['task_id'], // uuid
                      'createdBy': task['created_by'] ?? 'Unknown',
                      'createdAt': task['created_at'] ?? '',
                    })
                .toList()
          });
        }

        var finalData = Data.getColumns(
            jsonEncode(tasksForColumns)); //To fetch data form data.dart

        columns = finalData;

        // print(columns);

        setState(() {}); //for loading task data
      }
    } catch (e) {
      print(e);
    }

    return [];
  }

  // previous code without drawer - August 25, 2025
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('ITM Task Status'),
  //     ),
  //     body: SafeArea(
  //       child: KanbanBoard(
  //         columns: columns,
  //         controller: this,
  //         updateItemHandler: _showEditTask,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ITM Task Status'),
      ),
      drawer: Drawer(
        // <-- Add this drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                // Navigate to dashboard or other page if needed
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Column'),
              onTap: () {
                Navigator.pop(context);
                _showAddColumnDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to About page if needed
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: KanbanBoard(
          columns: columns,
          controller: this,
          updateItemHandler: _showEditTask,
        ),
      ),
    );
  } //end bulid

// Example: show dialog to add column from drawer
  void _showAddColumnDialog() {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Column'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Column Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  addColumn(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTask(int columnIndex, KTask task) {
    var editableTask = task; // Make a mutable local copy

    //print('----------------------$editableTask');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EditTaskForm(
          task: editableTask,
          onUpdate: (updatedTitle) {
            final updatedTask = task.copyWith(title: updatedTitle);

            setState(() {
              final taskIndex = columns[columnIndex]
                  .children
                  .indexWhere((t) => t.taskId == task.taskId);
              if (taskIndex != -1) {
                columns[columnIndex].children[taskIndex] = updatedTask;
              }
            });
            updateItem(columnIndex, updatedTask);
          },
        );
      },
    );
  }

  @override
  Future<void> deleteItem(int columnIndex, KTask task) async {
    // print('-------------delete Task---------');

    print('Deleted Task ID---------${task.taskId}');

    setState(() {
      columns[columnIndex].children.remove(task);
    });

    final dio = Dio();
    var url = "http://192.168.22.217/API/delete_task_kanban.php";
    print(url);

    try {
      var deletedData = {"id": task.taskId, "deleted_by": "muhsina"};
      Response response = await dio.post(
        url,
        data: deletedData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
    } catch (e) {
      print('Unexpected Issue $e');
    }
  }

  @override
  void handleReOrder(int oldIndex, int newIndex, int index) {
    setState(() {
      if (oldIndex != newIndex) {
        final task = columns[index].children[oldIndex];
        columns[index].children.remove(task);
        columns[index].children.insert(newIndex, task);
      }
    });
  }

  @override
  void addColumn(String title) async {
    setState(() {
      int newId = columns.length + 1; // Or use a unique ID generator if needed

      columns.add(KColumn(
        id: newId,
        title: title,
        children: List.of([]),
      ));
    });

    final dio = Dio();
    var url =
        'http://192.168.22.217/API/add_column_kanban.php'; //   print(url);

    try {
      var data = {
        "title": title,
        "created_by": "muhsina",
      };

      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      setState(() {});
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  @override
  void addTask(String title, int column) async {
    final String taskId = Uuid().v4(); // Generate a unique ID
    setState(() {
      //previous 2025-08-31  backup
      // columns[column].children.add(KTask(title: title, taskId: taskId));

      columns[column].children.add(
            KTask(
              title: title,
              taskId: taskId,
              createdBy: "muhsina", // or fetch from logged-in user
              createdAt: DateTime.now().toIso8601String(), // current time
            ),
          );
    });

    int columnId = columns[column]
        .id; // print(columnId); // This is where you get the column ID

    final dio = Dio();
    var url = "http://192.168.22.217/API/add_task_kanban.php";

    try {
      var data = {
        "title": title,
        "task_id": taskId, // Include the taskId in the data
        "column_id": columnId, // Dynamically added column ID
        "model_name": 1,
        "project_name": 1,
        "created_by": "muhsina"
      };

      // print(data);

      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('------------ Response Task Data -----------');
      print(response);
    } catch (e) {
      print('Unexpected Error: $e');
    }

    await getTaskData(); // refresh after submit
  }

  @override
  void dragHandler(KData data, int index) async {
    print(data);

    print('Task ID : ${data.taskId}');

    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });

    final dio = Dio();
    var url = "http://192.168.22.217/API/drag_drop_kanban.php";

    print(url);

    try {
      var requestData = {
        "id": data.taskId,
        "column_name": index + 1,
        "previous_status": data.from + 1,
        "model_name": 1,
        "project_name": 1,
        "status_change_by": "muhsina"
      };

      // print(requestData);

      Response response = await dio.post(
        url,
        data: requestData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
    } catch (e) {
      print('Enexpected Error $e');
    }
  }

  @override
  void updateItem(int columnIndex, KTask task) async {
    String updatedAt = DateTime.now().toString(); //print('--$updatedAt');
    final dio = Dio();

    var url = "http://192.168.22.217/API/update_task_kanban.php";

    print(url);

    try {
      var responseData = {
        "id": task.taskId,
        // "title": task.title,
        "title": task.title,
        "edited_by": "muhsina",
        "edited_at": updatedAt
      };

      print('----------Responsed Data---------$responseData');
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
      print('Response Data : ${response.data}');

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
}
