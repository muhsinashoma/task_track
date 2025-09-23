import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets/edit_task_widget.dart';
import '../widgets/kanban_board.dart';
import 'kanban_board_controller.dart';
import 'package:file_picker/file_picker.dart';

// class ProjectListItem {
//   final String id;
//   final String name;
//   final String project_owner_name; // add this
//   final String? attached_file; // add this as nullable

//   ProjectListItem({
//     required this.id,
//     required this.name,
//     required this.project_owner_name,
//     this.attached_file,
//   });

//   factory ProjectListItem.fromJson(Map<String, dynamic> json) {
//     return ProjectListItem(
//       id: json['id'].toString(),
//       name: json['project_name'] ?? "Unnamed Project",
//       project_owner_name: json['project_owner_name'] ?? "Unknown",
//       attached_file: json['attached_file'], // nullable
//     );
//   }
// }

class ProjectListItem {
  final int id;
  final String name;
  final String project_owner_name;
  final String? attached_file;

  ProjectListItem({
    required this.id,
    required this.name,
    required this.project_owner_name,
    this.attached_file,
  });

  factory ProjectListItem.fromJson(Map<String, dynamic> json) {
    return ProjectListItem(
      id: int.tryParse(json['id'].toString()) ?? 0, // safe parsing
      name: json['project_name'] ?? "Unnamed Project",
      project_owner_name: json['project_owner_name'] ?? "Unknown",
      attached_file: json['attached_file'],
    );
  }
}

// Format today's date
// DateTime now = DateTime.now();
// String englishDate = DateFormat("MMM dd, yyyy").format(now);

String? _selectedProjectName;
int? _selectedProjectId;
String? _projectOwnerName;
int _selectedProjectTaskCount = 0; // 👈 default 0

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
    getProjectListData();
  }

  String getFirstAndLastLetter(String name) {
    if (name.isEmpty) return "";
    if (name.length == 1) return name.toUpperCase();

    var parts = name.trim().split(" ");
    if (parts.length > 1) {
      return "${parts.first[0].toUpperCase()}${parts.last[0].toUpperCase()}";
    }
    return "${name[0].toUpperCase()}${name[name.length - 1].toUpperCase()}";
  }

// Generates a unique color for each project based on its index

  Color generateProjectColor(int index) {
    // Hue cycles through 0-360 degrees
    double hue =
        (index * 45) % 360; // change 45 to smaller/larger to control spacing
    double saturation = 0.6; // how vivid the color is
    double value = 0.85; // brightness of the color
    return HSVColor.fromAHSV(1, hue, saturation, value).toColor();
  }

  // ------------------- Fetch Projects---------------------
  List<ProjectListItem> _projects = [];
  bool _isLoadingProjects = true;

  Future<void> getProjectListData() async {
    try {
      final dio = Dio();
      var response = await dio.get(
        "http://192.168.0.100/API/get_project_list_kanban.php",
      );

      // Decode JSON string into a List
      List data = jsonDecode(response.data);

      _projects = data.map((json) => ProjectListItem.fromJson(json)).toList();

      setState(() {
        _isLoadingProjects = false;
      });

      //print("Projects loaded: ${_projects.length}");
    } catch (e) {
      print("Error fetching projects: $e");
      setState(() {
        _isLoadingProjects = false;
      });
    }
  }

  // ---------- Fetch columns ----------
  Future<void> getColumnData() async {
    try {
      final dio = Dio();
      var response =
          await dio.get("http://192.168.0.100/API/get_column_data_kanban.php");

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
        "http://192.168.0.100/API/get_task_data_kanban.php",
        queryParameters: {
          "project_id": _selectedProjectId ?? 0,
          "period": selectedNumber,
          "unit": selectedUnit.toLowerCase(),
        },
      );

      if (response.statusCode == 200) {
        var taskData = response.data['task_boards'] as List;

        List<Map<String, dynamic>> tasksForColumns = [];
        int totalTaskCount = 0; // 👈 new counter

        for (var board in taskData) {
          var tasks = board['tasks'] as List;
          totalTaskCount += tasks.length; // 👈 count tasks

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

        // Update columns
        columns = Data.getColumns(jsonEncode(tasksForColumns))
            .map((col) => col.copyWith(children: col.children ?? []))
            .toList();

        // Update task count 👇
        setState(() {
          _selectedProjectTaskCount = totalTaskCount;
        });
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

  String getInitials(String name) {
    if (name.isEmpty) return "?";

    List<String> parts = name.trim().split(" ");
    if (parts.length == 1) {
      String n = parts[0];
      return n.substring(0, 1).toUpperCase() +
          n.substring(n.length - 1).toUpperCase();
    } else {
      return parts.first.substring(0, 1).toUpperCase() +
          parts.last.substring(0, 1).toUpperCase();
    }
  }

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
      // ---------- App Bar ----------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: Row(
          children: [
// -------- Project Dropdown in AppBar ----------
            SizedBox(
              width: 180, // 👈 fixed standard width (tune this value)
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedProjectId,
                  hint: const Text(
                    "Select Project",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  items: _projects.asMap().entries.map((entry) {
                    int index = entry.key;
                    var project = entry.value;
                    Color projectColor = generateProjectColor(index);

                    return DropdownMenuItem<int>(
                      value: project.id,
                      child: Row(
                        children: [
                          Icon(Icons.folder, color: projectColor, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              project.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: projectColor,
                            child: Text(
                              getFirstAndLastLetter(project.project_owner_name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProjectId = value;
                      _selectedProjectName =
                          _projects.firstWhere((p) => p.id == value).name;
                    });
                    getTaskData();
                  },
                ),
              ),
            ),

            const SizedBox(width: 6),

            // -------- Task Count Avatar ----------
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: Text(
                '$_selectedProjectTaskCount',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // ----------- Period Filter ----------
            GestureDetector(
              onTap: _showPeriodDialog,
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, color: Colors.green, size: 18),
                  const SizedBox(width: 2),
                  Text(
                    periodText == "1 days"
                        ? "1d"
                        : periodText, // 👈 shorten "1 days" to "1d"
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ----------- Calendar ----------
            GestureDetector(
              onTap: _showCalendarModal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("MMM dd, yyyy")
                            .format(DateTime.now()), // 👈 formatted here
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(255, 47, 46, 46),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        banglaDate,
                        style: const TextStyle(
                          fontFamily: 'NotoSansBengali',
                          color: Color.fromARGB(255, 47, 46, 46),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        hijriDate,
                        style: const TextStyle(
                          fontFamily: 'NotoSansArabic',
                          color: Color.fromARGB(255, 47, 46, 46),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.calendar_today,
                    color: Color.fromARGB(255, 5, 144, 46),
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //---------Start Drawer----------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ---------- Drawer Header ----------
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/icons/task_management.png',
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black54,
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

            // ---------- Default Menu ----------
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
                backgroundColor: Colors.transparent,
              ),
              title: const Text('More App'),
              onTap: () => Navigator.pop(context),
            ),

            const Divider(),

            // ---------- Projects Section ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Projects",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  if (_projects.isNotEmpty)
                    Text(
                      // "Owner: ${_projects.first.project_owner_name}", // show beside My Projects

                      "Owner",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                ],
              ),
            ),

            if (_isLoadingProjects)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_projects.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No projects found."),
              )
            else
              ..._projects.asMap().entries.map((entry) {
                int index = entry.key;
                var project = entry.value;

                // Dynamic HSV-based color
                Color projectColor = generateProjectColor(index);

                return ListTile(
                  leading: Icon(
                    Icons.folder,
                    color: projectColor,
                  ),
                  title: Text(
                    project.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Tooltip(
                    message:
                        project.project_owner_name, // hover shows full name
                    child: CircleAvatar(
                      radius: 16, // 👈 slightly smaller, standard size
                      backgroundColor:
                          projectColor, // 🔥 unique color for each owner
                      child: Text(
                        getFirstAndLastLetter(project.project_owner_name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500, // medium
                          fontSize: 13, // 👈 balanced for radius 16
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // close drawer
                    setState(() {
                      _selectedProjectId = project.id;
                      _selectedProjectName = project.name;
                    });

                    // fetch tasks for this project
                    getTaskData();
                  },
                );
              }).toList(),
          ],
        ),
      ),
      //---------End Drawer----------

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

    File? selectedFile;

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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Project',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // Project Name
                    TextField(
                      controller: _projectController,
                      decoration: const InputDecoration(
                          labelText: 'Project Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.business)),
                    ),
                    const SizedBox(height: 12),

                    // Owner Name
                    TextField(
                      controller: _ownerController,
                      decoration: const InputDecoration(
                          labelText: 'Project Owner Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    const SizedBox(height: 12),

                    // File picker
                    ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg', 'xlsx'],
                        );
                        if (result != null) {
                          selectedFile = File(result.files.single.path!);
                          setState(() {}); // refresh button text
                        }
                      },
                      icon: const Icon(Icons.attach_file),
                      label: Text(selectedFile == null
                          ? "Pick File"
                          : "Selected: ${selectedFile!.path.split('/').last}"),
                    ),

                    const SizedBox(height: 12),

                    // Contact
                    TextField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 12),

                    // Email
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 12),

                    // Address
                    TextField(
                      controller: _addressController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                          labelText: 'Permanent Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on)),
                    ),
                    const SizedBox(height: 20),

                    // ---------------- Add Project Buttons ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            final projectName = _projectController.text.trim();
                            final ownerName = _ownerController.text.trim();
                            final contact = _contactController.text.trim();
                            final email = _emailController.text.trim();
                            final address = _addressController.text.trim();

                            // --- Field Validations ---
                            if (projectName.isEmpty ||
                                ownerName.isEmpty ||
                                contact.isEmpty ||
                                email.isEmpty) {
                              _showErrorDialog(context,
                                  "Project name, owner, contact and email are required.");
                              return;
                            }

                            if (!phoneRegex.hasMatch(contact)) {
                              _showErrorDialog(context,
                                  "Please enter a valid Bangladeshi mobile number (11 digits, starts with 01).");
                              return;
                            }

                            if (!emailRegex.hasMatch(email)) {
                              _showErrorDialog(context,
                                  "Please enter a valid email address.");
                              return;
                            }

                            // --- API Call ---
                            try {
                              final res = await addProjectDetails(
                                projectName: projectName,
                                ownerName: ownerName,
                                contact: contact,
                                email: email,
                                address: address,
                                file: selectedFile,
                              );

                              print("Response: $res");

                              // Show success/error in SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      res['message'] ?? "Upload completed"),
                                  backgroundColor: res['success']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              );

                              if (res['success'] == true) {
                                // Clear form fields
                                _projectController.clear();
                                _ownerController.clear();
                                _contactController.clear();
                                _emailController.clear();
                                _addressController.clear();
                                setState(() {
                                  selectedFile = null;
                                });

                                // Close dialog
                                Navigator.pop(context);

                                // Refresh project list instantly
                                await getProjectListData();
                              }
                            } catch (e) {
                              print("Upload error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Upload failed: $e"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    ),

                    //To End add Project Buttons
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// utils.dart (or top of your widget file, before the class)
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

// Regex validators
  final phoneRegex = RegExp(r'^(01)[0-9]{9}$'); // Bangladeshi 11-digit number
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

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

  // ------------------ Add Project ------------------
  Future<Map<String, dynamic>> addProjectDetails({
    required String projectName,
    required String ownerName,
    required String contact,
    required String email,
    required String address,
    File? file,
  }) async {
    FormData formData = FormData.fromMap({
      "project_name": projectName,
      "project_owner_name": ownerName,
      "contact_number": contact,
      "email_address": email,
      "permanent_address": address,
      "created_by": ownerName,
      if (file != null)
        "attached_file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    });

    final dio = Dio();

    try {
      final response = await dio.post(
        "http://192.168.0.100/API/add_project_kanban.php",
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          responseType: ResponseType.plain, // 👈 treat as plain text first
        ),
      );

      print("✅ Raw Response: ${response.data}");

      // Decode manually
      final Map<String, dynamic> decoded = jsonDecode(response.data);

      return decoded;
    } catch (e) {
      print("❌ Upload error: $e");
      return {"success": false, "message": "Upload failed: $e"};
    }
  }

  @override
  void addColumn(String title) async {
    int newId = columns.length + 1;
    setState(() => columns.add(KColumn(id: newId, title: title, children: [])));
    final dio = Dio();
    try {
      await dio.post(
        'http://192.168.0.100/API/add_column_kanban.php',
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
        "http://192.168.0.100/API/add_task_kanban.php",
        data: {
          "title": title,
          "task_id": taskId,
          "column_id": columnId,
          "model_name": 1,
          //"project_name": 1,
          "project_id": 1,
          "created_by": "muhsina",
          // "project_name": _selectedProjectId, // 👈 link to project
          // "created_by": _projectOwnerName,
        },
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      );
    } catch (e) {
      print("Add task error: $e");
    }
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
        "http://192.168.0.100/API/delete_task_kanban.php",
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
  void dragHandler(KData data, int index) async {
    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });
    final dio = Dio();
    try {
      await dio.post(
        "http://192.168.0.100/API/drag_drop_kanban.php",
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
        "http://192.168.0.100/API/update_task_kanban.php",
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
