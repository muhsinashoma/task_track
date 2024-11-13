// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import '../models/models.dart';

class Data {
  static List<KColumn> getColumns([String? data]) {
    // Decode the JSON data
    List<dynamic> jsonData = jsonDecode(data!);

    return jsonData.map((item) {
      List<KTask> tasks = [];

      // Check if there are tasks in this column
      if (item['tasks'] != null) {
        tasks = (item['tasks'] as List).map((task) {
          // Create KTask with title and taskId
          return KTask(
            title: task['title'],
            taskId: task['id'].toString(), // Assuming 'id' is the taskId
          );
        }).toList();
      }

      // Return the KColumn object
      return KColumn(
        id: int.tryParse(item['id'].toString()) ??
            0, // Ensure 'id' is parsed as an integer
        title: item['title'],
        children: tasks, // Assign the tasks to the children
      );
    }).toList();
  }
}
