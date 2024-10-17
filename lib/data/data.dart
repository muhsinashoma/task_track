// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import '../models/models.dart';

class Data {
  static List<KColumn> getColumns([String? data]) {
    // print("Column Data");
    // print('----------------------------------');
    // print(data);
    // print('----------------------------------');

    // Decode the JSON data
    List<dynamic> jsonData = jsonDecode(data!);

    // print('----------------------------------');
    // print(jsonData);
    // print('----------------------------------');

    return jsonData.map((item) {
      print(item['id']);
      print(item['title']);

      // Fetching current column

      List<KTask> tasks = [];

      if (item['tasks'] != null) {
        tasks = (item['tasks'] as List).map((task) {
          return KTask(title: task['title']);
        }).toList();
      }

      return KColumn(
        // id: item['id'],
        title: item['title'],
        children: tasks, // Ignoring children as per your requirement
      );
    }).toList();
  }
}
