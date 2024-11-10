import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets/kanban_board.dart';
import 'kanban_board_controller.dart';

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

  @override
  void addTask(String title, int column) async {
    // Add the task locally
    setState(() {
      columns[column].children.add(KTask(title: title));
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

  @override
  void dragHandler(KData data, int index) {
    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });
  }
}