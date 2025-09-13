import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

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
  // ------------------ Add this ------------------
  DateTime selectedDate = DateTime.now();
  // ---------- Selected period ----------
  int selectedNumber = 1;
  String selectedUnit = "Days"; // default period
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

  // ---------- Kanban columns ----------
  List<KColumn> columns = [];

  @override
  void initState() {
    super.initState();
    getColumnData();
    getTaskData();
  }

  // ---------- Fetch columns ----------
  Future<void> getColumnData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.0.104/API/get_column_data_kanban.php");

      columns = Data.getColumns(response.data)
          .map((col) => col.copyWith(children: col.children ?? []))
          .toList();

      setState(() {});
    } catch (e) {
      print("Error fetching columns: $e");
    }
  }

  // ---------- Fetch tasks ----------
  Future<void> getTaskData() async {
    try {
      final dio = Dio();
      var response = await dio.get(
        "http://192.168.0.104/API/get_task_data_kanban.php",
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
      print("Error fetching tasks: $e");
    }
  }

  // ------------------- Date Suffix -------------------
  String suffix(int day) {
    if (day == 1 || day == 21 || day == 31) return 'st';
    if (day == 2 || day == 22) return 'nd';
    if (day == 3 || day == 23) return 'rd';
    return 'th';
  }

// Add a variable in your StatefulWidget
  String _currentProjectName = ''; // stores the project name
  // ------------------ Build UI ------------------
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // English
    final englishDate = DateFormat('MMMM dd, yyyy').format(now);

    // Bangla
    final banglaDate = DateFormat('d MMMM yyyy', 'bn').format(now);

    // Hijri
    final hijri = HijriCalendar.fromDate(now);
    final hijriDate =
        "${hijri.hDay}${suffix(hijri.hDay)} ${hijri.longMonthName} ${hijri.hYear} AH";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: Row(
          children: [
            // ----------- Left: Project Name / ITM ----------
            const Text(
              'ITM', // or replace with your project name
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),

            // ----------- Left: Period Filter ----------
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
            const Spacer(),

            // ----------- Right: Calendars ----------
            GestureDetector(
              onTap: _showCalendarModal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        englishDate,
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromARGB(255, 47, 46, 46),
                            fontSize: 12),
                      ),
                      Text(
                        banglaDate,
                        style: const TextStyle(
                            fontFamily: 'NotoSansBengali',
                            color: Color.fromARGB(255, 47, 46, 46),
                            fontSize: 12),
                      ),
                      Text(
                        hijriDate,
                        style: const TextStyle(
                            fontFamily: 'NotoSansArabic',
                            color: Color.fromARGB(255, 47, 46, 46),
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.calendar_today,
                      color: Color.fromARGB(255, 5, 144, 46), size: 20),
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
            // const DrawerHeader(
            //   decoration:
            //       BoxDecoration(color: Color.fromARGB(255, 171, 250, 172)),
            //   child: Text('Menu',
            //       style: TextStyle(color: Colors.black, fontSize: 24)),
            // ),

            DrawerHeader(
              padding: EdgeInsets.zero, // remove default padding
              child: Stack(
                fit: StackFit.expand, // fill the entire DrawerHeader
                children: [
                  // Background image
                  Image.asset(
                    'assets/icons/task_management.png',
                    fit: BoxFit.cover, // fills the entire header
                  ),
                  // Title at the bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors
                          .black54, // optional: semi-transparent background for text
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Task Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
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
              title: const Text('About Me'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 18,
                backgroundImage: const AssetImage('assets/icons/app_icon.png'),
                backgroundColor: Colors.transparent, // optional
              ),
              title: const Text('More App'),
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

      // ---------- Add floating + button ----------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProjectDialog(); // your add project dialog
        },
        backgroundColor: const Color.fromARGB(255, 147, 229, 150),
        child: const Icon(Icons.add),
        tooltip: 'Add Project',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

// ---------- Project Dialog ---------
  void _showAddProjectDialog() {
    final _projectController = TextEditingController();
    final _ownerController = TextEditingController();
    final _contactController = TextEditingController();
    final _emailController = TextEditingController();
    final _addressController = TextEditingController();

    String? _errorMessage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Project',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // ----------- Error Message -----------
                    if (_errorMessage != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 147, 229, 150),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Project Name
                    TextField(
                      controller: _projectController,
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Owner Name
                    TextField(
                      controller: _ownerController,
                      decoration: const InputDecoration(
                        labelText:
                            'Project Owner/Responsible Person/Company Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Owner Image
                    GestureDetector(
                      onTap: () {
                        // Image picker logic
                        print('Pick image');
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.camera_alt, size: 28),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Contact Number
                    TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email Address
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Permanent Address
                    TextField(
                      controller: _addressController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Permanent Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_projectController.text.isEmpty ||
                                _ownerController.text.isEmpty ||
                                _contactController.text.isEmpty ||
                                _emailController.text.isEmpty) {
                              setState(() {
                                _errorMessage =
                                    'Project name, owner, contact and email required';
                              });
                            } else {
                              setState(() {
                                _currentProjectName = _projectController
                                    .text; // update project name
                                _errorMessage = null;
                              });

                              // Optional: handle other data
                              print("Project: ${_projectController.text}");
                              print("Owner: ${_ownerController.text}");
                              print("Contact: ${_contactController.text}");
                              print("Email: ${_emailController.text}");
                              print("Address: ${_addressController.text}");

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ Period Dialog ------------------
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
              setState(() {}); // update AppBar
              Navigator.pop(context);
              getTaskData(); // fetch tasks instantly
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _showCalendarModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: 400,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(text: 'English'),
                    Tab(text: 'Bangla'),
                    Tab(text: 'Hijri'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildEnglishCalendar(),
                      _buildBanglaCalendar(),
                      _buildHijriCalendar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// ---------------- Calendar Builders ----------------

  Widget _buildEnglishCalendar() {
    return CalendarDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onDateChanged: (date) {
        setState(() => selectedDate = date);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBanglaCalendar() {
    return CalendarDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onDateChanged: (date) {
        setState(() => selectedDate = date);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildHijriCalendar() {
    return CalendarDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onDateChanged: (date) {
        setState(() => selectedDate = date);
        Navigator.pop(context);
      },
    );
  }

  // ------------------ Add Column ------------------
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

  // ------------------ Edit Task ------------------
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

  // ------------------ KanbanBoardController ------------------
  @override
  Future<void> deleteItem(int columnIndex, KTask task) async {
    setState(() => columns[columnIndex].children.remove(task));
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.0.104/API/delete_task_kanban.php",
        data: {"id": task.taskId, "deleted_by": "muhsina"},
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      print("Delete error: $e");
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
        'http://192.168.0.104/API/add_column_kanban.php',
        data: {"title": title, "created_by": "muhsina"},
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      print("Add column error: $e");
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
    setState(() => columns[column].children.insert(0, newTask));

    final dio = Dio();
    try {
      int columnId = columns[column].id;
      await dio.post(
        "http://192.168.0.104/API/add_task_kanban.php",
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
      print("Add task error: $e");
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
        "http://192.168.0.104/API/drag_drop_kanban.php",
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
      print("Drag error: $e");
    }
  }

  @override
  void updateItem(int columnIndex, KTask task) async {
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.0.104/API/update_task_kanban.php",
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
      print("Update error: $e");
    }
  }
}
