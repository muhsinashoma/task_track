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
          // Create KTask with all required fields
          return KTask(
            title: task['title'],
            taskId: task['id'].toString(),
            createdBy: task['createdBy'] ?? "unknown", // 👈 fallback if missing
            createdAt: task['createdAt'] ??
                DateTime.now().toIso8601String(), // 👈 fallback
            projectId: int.tryParse(task['project_id']?.toString() ?? "0") ??
                0, // 👈 add this
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
