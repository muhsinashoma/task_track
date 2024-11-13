import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../data/data.dart';
import '../../models/models.dart';
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
          await dio.get("http://192.168.34.206/API/get_column_data_kanban.php");

      // print('----------Response Data----------------------------');

      //print(response);

      // print('--------Board Name and ID number---------------');

      columns = Data.getColumns(response.data);

      //print(columns);

      //print('--------Board Name and ID number---------------');

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  getTaskData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.34.206/API/get_task_data_kanban.php");

      //print("--------------All Data-----------------");

      // print(response);

      if (response.statusCode == 200) {
        var taskData = response.data['task_boards'] as List;

        // print(taskData);

        //Collect Tasks for column

        List<Map<String, dynamic>> tasksForColumns = [];

        for (var board in taskData) {
          var tasks = board['tasks'] as List;

          // print(tasks);

          // tasksForColumns.add({
          //   'id': board['id'],
          //   'title': board['title'],
          //   'tasks': tasks
          //       .map((task) => {'id': task['id'], 'title': task['title']})
          //       .toList()
          // });

          tasksForColumns.add({
            'id': int.tryParse(board['id'].toString()) ??
                0, // Ensure it's an integer
            'title': board['title'],
            'tasks': tasks
                .map((task) => {
                      'id': int.tryParse(task['id'].toString()) ??
                          0, // Ensure task id is an integer
                      'title': task['title']
                    })
                .toList()
          });
        }

        //  print('-----------Task under columns-------');

        //  print(jsonEncode(tasksForColumns)); //To fetch all data

        //To fetch task data under column from data.dart page

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ITM Task Status'),
      ),
      body: SafeArea(
        child: KanbanBoard(
          columns: columns,
          controller: this,
        ),
      ),
    );
  }

  @override
  void deleteItem(int columnIndex, KTask task) {
    setState(() {
      columns[columnIndex].children.remove(task);
    });
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
    // print('--------------add column---------------');
    setState(() {
      // Generate a temporary ID (for example, using the length of columns)
      int newId = columns.length + 1; // Or use a unique ID generator if needed

      columns.add(KColumn(
        id: newId,
        title: title,
        children: List.of([]),
      ));
    });

    final dio = Dio();
    var url = 'http://192.168.34.206/API/add_column_kanban.php';

    print(url);

    try {
      var data = {
        "title": title,
        "created_by": "muhsina",
      };

      // print("data--------------------------");
      //print(data);
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

      // print('---------------------');
      // print(response);
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  // @override
  // void addTask(String title, int column) {
  //   setState(() {
  //     columns[column].children.add(KTask(title: title));
  //   });
  // }

// Assuming you have a KTask class like this:
// class KTask {
//   final String title;
//   final String taskId;

//   KTask({required this.title, required this.taskId});
// }

  @override
  void addTask(String title, int column) async {
    // Generate a unique taskId using the uuid package
    final String taskId = Uuid().v4(); // Generate a unique ID

    // Add the task locally with taskId
    setState(() {
      columns[column].children.add(KTask(title: title, taskId: taskId));
    });

    // Fetch the column ID dynamically using the column index
    int columnId = columns[column].id;

    print('------------- Dynamically Column ID -------------');
    print(columnId); // This is where you get the column ID
    print('------------------------------------------------');

    final dio = Dio();
    var url = "http://192.168.34.206/API/add_task_kanban.php";

    try {
      var data = {
        "title": title,
        "task_id": taskId, // Include the taskId in the data
        "column_id": columnId, // Dynamically added column ID
        "model_name": 1,
        "project_name": 1,
        "created_by": "muhsina"
      };

      print('------------ Task Data -----------');
      print(data);

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
  }

  //Backup 11-11-2024
  // @override
  // void dragHandler(KData data, int index) {
  //   setState(() {
  //     columns[data.from].children.remove(data.task);
  //     columns[index].children.add(data.task);
  //   });
  // }

  @override
  void dragHandler(KData data, int index) async {
    print('---------------Drag and Drop------------');

    print('---------from---------+${data.from}');
    print(data.from);

    print(data);

    //Assuming KData has a taskId attribute
    print('Task ID : ${data.taskId}');

    // int taskId = data.taskId;
    print('--------------index-----------${index}');

    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });

    print('--------------------------');

    //int taskId = data.taskId;
    print(data.taskId);
    print(data.from);

    final dio = Dio();
    var url = "http://192.168.34.206/API/drag_drop_kanban.php";

    print(url);

    try {
      var requestData = {
        "id": data.taskId,
        "column_name": index,
        "previous_status": data.from,
        "model_name": 1,
        "project_name": 1,
        "status_change_by": "muhsina"
      };

      print('---------------------------Drag and Drop Task');
      print(requestData);

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

// @override
//   void dragHandler(KData data, int index) async {
//     print('---------------Drag and Drop------------');

//     print('---------from---------${data.from}');
//     print(data);

//     // Assuming KData has a taskId attribute
//     print('Task ID: ${data.taskId}');
//    // int taskId = data.taskId;

//     print('--------------index-----------$index');

//     setState(() {
//       columns[data.from].children.remove(data.task);
//       columns[index].children.add(data.task);
//     });

//     final dio = Dio();
//     const String url = "http://192.168.34.206/drag_drop_kanban.php";

//     print(url);

//     try {
//       var requestData = {
//         "id": taskId,
//         "column_name": index,
//         "previous_status": data.from,
//         "model_name": 1,
//         "project_name": 1,
//         "status_change_by": "muhsina"
//       };

//       print('---------------------------Drag and Drop Task');
//       print(requestData);

//       Response response = await dio.post(
//         url,
//         data: requestData,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/x-www-form-urlencoded',
//           },
//         ),
//       );

//       // Optional: handle the response if needed
//       if (response.statusCode == 200) {
//         print('Task updated successfully.');
//       } else {
//         print('Failed to update task. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Unexpected Error: $e');
//     }
//   }
}
