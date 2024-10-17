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
          await dio.get("http://192.168.34.17/API/get_column_data_kanban.php");

      // print('----------Response Data----------------------------');

      //print(response);

      print('--------Board Name and ID number---------------');

      columns = Data.getColumns(response.data);

      print(columns);

      print('--------Board Name and ID number---------------');

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  getTaskData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.34.17/API/get_task_data_kanban.php");

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

          tasksForColumns.add({
            'id': board['id'],
            'title': board['title'],
            'tasks': tasks
                .map((task) => {'id': task['id'], 'title': task['title']})
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

      print('--------------------------------');
    } catch (e) {
      print(e);
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set State--------------------------'),
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
      columns.add(KColumn(
        title: title,
        children: List.of([]),
      ));
    });

    final dio = Dio();
    var url = 'http://192.168.34.17/API/add_column_kanban.php';

    print(url);

    try {
      var data = {
        "title": title,
        "created_by": "muhisna",
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
    setState(() {
      columns[column].children.add(KTask(title: title));
    });

    // Fetch the column name dynamically

    String columnName = columns[column].title;

    print('-------------Dynamically Column ID------------------');

    print(columnName);

    // columns = Data.getColumns(columns.data);

    print(columns);

    print('-------------Dynamically Column ID------------------');
    final dio = Dio();
    var url = ("http://192.168.34.17/API/add_task_kanban.php");

    print(url);

    try {
      var data = {
        "title": title,
        "column_name": columnName,
        "model_name": 1,
        "project_name": 1,
        "created_by": "muhsina"
      };

      print('------------Task Data-----------');

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

      print('------------Response Task Data-----------');
      print(response);
    } catch (e) {
      print('Unexpected Error $e');
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
