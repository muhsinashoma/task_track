import 'dart:convert';

// import 'package:bangla_utilities/bangla_utilities.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets/edit_task_widget.dart';
import '../widgets/kanban_board.dart';
import 'kanban_board_controller.dart';

class KanbanSetStatePage extends StatefulWidget {
  const KanbanSetStatePage({super.key});

  @override
  State<KanbanSetStatePage> createState() => _KanbanSetStatePageState();
}

class _KanbanSetStatePageState extends State<KanbanSetStatePage>
    implements KanbanBoardController {
  // ---------- Dates ----------

  // ---------- Dates ----------
  Future<String> getTodayDate() async {
    DateTime now = DateTime.now();

    // English (Gregorian)
    String englishDate = DateFormat('MMM dd, yyyy').format(now);

    // Arabic (Hijri) via API
    String arabicDate = await getHijriDate(now);

    // Bangla (Bengali)
    String banglaDate = getBanglaDate(now);

    return "📅 English: $englishDate\n🕌 Arabic: $arabicDate\n🇧🇩 Bangla: $banglaDate";
  }

  // ---------------- Hijri Date using API ----------------
  Future<String> getHijriDate(DateTime date) async {
    try {
      final dio = Dio();
      final formatted = DateFormat('dd-MM-yyyy').format(date);
      final response = await dio.get(
        'http://api.aladhan.com/v1/gToH',
        queryParameters: {'date': formatted},
      );
      final hijri = response.data['data']['hijri'];
      return "${hijri['day']} ${hijri['month']['en']} ${hijri['year']} هـ";
    } catch (e) {
      return "Hijri date error";
    }
  }

  // ---------------- Bangla Date Conversion ----------------
  String getBanglaDate(DateTime date) {
    List<String> banglaMonths = [
      "বৈশাখ",
      "জ্যৈষ্ঠ",
      "আষাঢ়",
      "শ্রাবণ",
      "ভাদ্র",
      "আশ্বিন",
      "কার্তিক",
      "অগ্রহায়ণ",
      "পৌষ",
      "মাঘ",
      "ফাল্গুন",
      "চৈত্র"
    ];

    DateTime banglaNewYear = DateTime(date.year, 4, 14);
    int daysDiff = date.difference(banglaNewYear).inDays;

    int monthIndex = (daysDiff ~/ 30) % 12; // approximate month
    int day = (daysDiff % 30) + 1;
    int banglaYear = date.year - 593;
    if (daysDiff < 0) banglaYear -= 1; // before Bangla New Year

    return "$day ${banglaMonths[monthIndex]} $banglaYear বঙ্গাব্দ";
  }

  // ---------- Period Selection ----------
  int selectedNumber = 1;
  String selectedUnit = "Days";

  final List<int> numbers = List.generate(10, (i) => i + 1);
  final List<String> units = [
    "Days",
    "Months",
    "Years",
    "Last Days",
    "Last Months",
    "Last Years"
  ];

  String get periodText => "$selectedNumber $selectedUnit";

  // ---------- Kanban Data ----------
  List<KColumn> columns = [];

  @override
  void initState() {
    super.initState();
    getColumnData();
    getTaskData();
  }

  // Fetch column data
  Future<void> getColumnData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.1.106/API/get_column_data_kanban.php");

      columns = Data.getColumns(response.data)
          .map((col) => col.copyWith(children: col.children ?? []))
          .toList();

      setState(() {});
    } catch (e) {
      debugPrint("Error fetching columns: $e");
    }
  }

  // Fetch task data
  Future<void> getTaskData() async {
    try {
      final dio = Dio();
      var response = await dio.get(
        "http://192.168.1.106/API/get_task_data_kanban.php",
        queryParameters: {
          "period": selectedNumber,
          "unit": selectedUnit.toLowerCase(),
        },
      );

      if (response.statusCode == 200) {
        var taskData = response.data['task_boards'] as List;

        List<Map<String, dynamic>> tasksForColumns = [];
        for (var board in taskData) {
          var tasks = board['tasks'] as List;
          tasksForColumns.add({
            'id': int.tryParse(board['id'].toString()) ?? 0,
            'title': board['title'],
            'tasks': tasks
                .map((task) => {
                      'id': int.tryParse(task['id'].toString()) ?? 0,
                      'title': task['title'],
                      'taskId': task['task_id'],
                      'createdBy': task['created_by'] ?? 'Unknown',
                      'createdAt': task['created_at'] ?? '',
                    })
                .toList(),
          });
        }

        columns = Data.getColumns(jsonEncode(tasksForColumns))
            .map((col) => col.copyWith(children: col.children ?? []))
            .toList();

        setState(() {});
      }
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    }
  }

  // ---------- Build UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: Row(
          children: [
            const Text(
              'ITM',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),

            // Period Filter
            GestureDetector(
              onTap: _showPeriodDialog,
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, color: Colors.green, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    periodText,
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Schedule Button
            GestureDetector(
              onTap: _showScheduleDialog,
              child: Row(
                children: const [
                  Icon(Icons.calendar_today,
                      color: Color.fromARGB(255, 19, 12, 9), size: 20),
                  SizedBox(width: 4),
                  Text(
                    "Schedule",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 189, 237, 190)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.black, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
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
              onTap: () => Navigator.pop(context),
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
  }

  // ------------------ Dialogs ------------------
  void _showPeriodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Select Period"),
        content: StatefulBuilder(
          builder: (context, setStateDialog) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: numbers.contains(selectedNumber)
                    ? selectedNumber
                    : numbers.first,
                isExpanded: true,
                items: numbers
                    .map((num) => DropdownMenuItem(
                          value: num,
                          child: Text(num.toString()),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setStateDialog(() => selectedNumber = value!),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value:
                    units.contains(selectedUnit) ? selectedUnit : units.first,
                isExpanded: true,
                items: units
                    .map((unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setStateDialog(() => selectedUnit = value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
              getTaskData();
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _showAddColumnDialog() {
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Column'),
        content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Column Name')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
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
      ),
    );
  }

  void _showEditTask(int columnIndex, KTask task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EditTaskForm(
        task: task,
        onUpdate: (updatedTitle) {
          final updatedTask = task.copyWith(title: updatedTitle);
          setState(() {
            final taskIndex = columns[columnIndex]
                .children
                .indexWhere((t) => t.taskId == task.taskId);
            if (taskIndex != -1)
              columns[columnIndex].children[taskIndex] = updatedTask;
          });
          updateItem(columnIndex, updatedTask);
        },
      ),
    );
  }

  // 🔥 Schedule Dialog
  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Today's Date"),
        content: FutureBuilder<String>(
          future: getTodayDate(), // async function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching date');
            } else {
              return Text(
                snapshot.data ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5),
              );
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close")),
        ],
      ),
    );
  }

  // ------------------ KanbanBoardController Implementation ------------------
  @override
  Future<void> deleteItem(int columnIndex, KTask task) async {
    setState(() => columns[columnIndex].children.remove(task));
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.1.106/API/delete_task_kanban.php",
        data: {"id": task.taskId, "deleted_by": "muhsina"},
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      debugPrint("Delete error: $e");
    }
  }

  @override
  void handleReOrder(int oldIndex, int newIndex, int index) {
    setState(() {
      if (oldIndex != newIndex) {
        final task = columns[index].children.removeAt(oldIndex);
        columns[index].children.insert(newIndex, task);
      }
    });
  }

  @override
  void addColumn(String title) async {
    int newId = columns.length + 1;
    setState(() => columns.add(KColumn(id: newId, title: title, children: [])));
    final dio = Dio();
    try {
      await dio.post(
        'http://192.168.1.106/API/add_column_kanban.php',
        data: {"title": title, "created_by": "muhsina"},
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      debugPrint("Add column error: $e");
    }
  }

  @override
  void addTask(String title, int column) async {
    final taskId = Uuid().v4();
    final newTask = KTask(
      title: title,
      taskId: taskId,
      createdBy: "muhsina",
      createdAt: DateTime.now().toIso8601String(),
    );
    setState(() => columns[column].children.add(newTask));

    final dio = Dio();
    try {
      int columnId = columns[column].id;
      await dio.post(
        "http://192.168.1.106/API/add_task_kanban.php",
        data: {
          "title": title,
          "task_id": taskId,
          "column_id": columnId,
          "model_name": 1,
          "project_name": 1,
          "created_by": "muhsina"
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      debugPrint("Add task error: $e");
    }
  }

  @override
  void dragHandler(KData data, int index) async {
    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.1.106/API/drag_drop_kanban.php",
        data: {
          "id": data.taskId,
          "column_name": index + 1,
          "previous_status": data.from + 1,
          "model_name": 1,
          "project_name": 1,
          "status_change_by": "muhsina"
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      debugPrint("Drag error: $e");
    }
  }

  @override
  void updateItem(int columnIndex, KTask task) async {
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.1.106/API/update_task_kanban.php",
        data: {
          "id": task.taskId,
          "title": task.title,
          "edited_by": "muhsina",
          "edited_at": DateTime.now().toString()
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      debugPrint("Update error: $e");
    }
  }
}
