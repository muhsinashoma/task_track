import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
//import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../../url/api_service.dart'; // Import your baseUrl
import '../widgets/edit_task_widget.dart';
import '../widgets/kanban_board.dart';
import 'about_me_page.dart';
import 'arabic_words_in_bangla.dart';
import 'kanban_board_controller.dart';
//import 'package:dropdown_search/dropdown_search.dart';
//import '../../models/project_list_item.dart';

class ProjectListItem {
  final int id;
  final String name;
  final String project_owner_name;
  final String? attached_file;
  int taskCount;

  ProjectListItem({
    required this.id,
    required this.name,
    required this.project_owner_name,
    this.attached_file,
    this.taskCount = 0,
  });

  factory ProjectListItem.fromJson(Map<String, dynamic> json) {
    return ProjectListItem(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['project_name'] ?? "Unnamed Project",
      project_owner_name: json['project_owner_name'] ?? "Unknown",
      attached_file: json['attached_file'],
      taskCount: int.tryParse(json['task_count']?.toString() ?? "0") ?? 0,
    );
  }
}

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
  // ---------------------- USER IDENTIFIER ----------------------

//The function you posted creates and stores a unique ID for that device:
  Future<String> getUserIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('user_identifier');
    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString('user_identifier', id);
    }
    return id;
  }

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
    //getColumnData();
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

      // ✅ Step 1: Build your URL using baseUrl
      var url = Uri.parse("${baseUrl}get_project_list_kanban.php");
      print("Fetching project list from: $url");

      // ✅ Step 2: Make the request
      var response = await dio.get(url.toString());

      // ✅ Step 3: Decode response
      List data = jsonDecode(response.data);

      _projects = data.map((json) => ProjectListItem.fromJson(json)).toList();

      setState(() {
        _isLoadingProjects = false;
      });

      print("Projects loaded: ${_projects.length}");
    } catch (e) {
      print("Error fetching projects: $e");
      setState(() {
        _isLoadingProjects = false;
      });
    }
  }

  // Future<void> getProjectListData() async {
  //   try {
  //     final dio = Dio();
  //     var response = await dio.get(
  //       "http://192.168.0.103/API/get_project_list_kanban.php",
  //     );

  //     // Decode JSON string into a List
  //     List data = jsonDecode(response.data);

  //     _projects = data.map((json) => ProjectListItem.fromJson(json)).toList();

  //     setState(() {
  //       _isLoadingProjects = false;
  //     });

  //     //print("Projects loaded: ${_projects.length}");
  //   } catch (e) {
  //     print("Error fetching projects: $e");
  //     setState(() {
  //       _isLoadingProjects = false;
  //     });
  //   }
  // }

// Function to generate day widgets with correct weekday alignment
  List<Widget> buildCalendarDays(
      int year, int month, int daysInMonth, int todayDay, Set<int> holidays) {
    List<Widget> dayWidgets = [];

    // Weekday list
    List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    // First day weekday (Sunday=0)
    int firstWeekday = DateTime(year, month, 1).weekday % 7;

    // Add empty widgets for days before first day
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container(width: 28, height: 40));
    }

    return dayWidgets;
  }

//--------------------back to getTaskData To show Kanban Board -----------------------

  Future<void> getTaskData() async {
    try {
      final dio = Dio();

      // Use baseUrl here
      var url = Uri.parse("${baseUrl}get_task_data_kanban.php");
      print("Fetching data from: $url");

      var response = await dio.get(
        url.toString(),
        queryParameters: {
          "project_id": _selectedProjectId ?? 0,
          "period": selectedNumber,
          "unit": selectedUnit.toLowerCase(),
        },
      );

      if (response.statusCode == 200) {
        var taskData = response.data['task_boards'] as List;

        List<Map<String, dynamic>> tasksForColumns = [];
        int totalTaskCount = 0;

        for (var board in taskData) {
          var tasks = board['tasks'] as List;
          totalTaskCount += tasks.length;

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

        List<KColumn> fetchedColumns =
            Data.getColumns(jsonEncode(tasksForColumns))
                .map((col) => col.copyWith(children: col.children ?? []))
                .toList();

        columns = List.generate(
          fetchedColumns.length,
          (index) => fetchedColumns[index].copyWith(
            color: generateProjectColor(index),
          ),
        );

        setState(() {
          _selectedProjectTaskCount = totalTaskCount;
        });
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

//---------------------------------Add Project using Based UrL---------------------------

  Future<Map<String, dynamic>> addProjectDetails({
    required String projectName,
    required String ownerName,
    required String contact,
    required String email,
    required String address,
    File? file,
  }) async {
    // 🔹 Get unique device/user ID
    String userIdentifier = await getUserIdentifier();

    FormData formData = FormData.fromMap({
      "project_name": projectName,
      "project_owner_name": ownerName,
      "contact_number": contact,
      "email_address": email,
      "permanent_address": address,
      "created_by": ownerName,
      "user_identifier": userIdentifier,
      if (file != null)
        "attached_file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    });

    final dio = Dio();

    try {
      // ✅ Use baseUrl instead of hardcoding
      var url = Uri.parse("${baseUrl}add_project_kanban.php");
      print("📡 Sending project to: $url");

      final response = await dio.post(
        url.toString(),
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          responseType: ResponseType.plain, // treat as plain text
        ),
      );

      print("✅ Raw Response: ${response.data}");

      final Map<String, dynamic> decoded = jsonDecode(response.data);
      return decoded;
    } catch (e) {
      print("❌ Upload error: $e");
      return {"success": false, "message": "Upload failed: $e"};
    }
  }

  //---------------------------Add Column using Based UrL----------------------------

  @override
  void addColumn(String title) async {
    int newId = columns.length + 1;

    // ✅ Add locally for instant UI response
    setState(() => columns.add(KColumn(id: newId, title: title, children: [])));

    final dio = Dio();
    String userIdentifier =
        await getUserIdentifier(); // from shared_preferences
    String projectId = _selectedProjectId.toString();

    try {
      // ✅ Use baseUrl instead of hardcoding
      var url = Uri.parse("${baseUrl}add_column_kanban.php");
      print("📡 Sending column to: $url");

      final response = await dio.post(
        url.toString(),
        data: {
          "title": title,
          "project_id": projectId,
          "user_identifier": userIdentifier,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print("✅ Add Column Response: ${response.data}");
    } catch (e) {
      print("❌ Add column error: $e");
    }
  }

//-----------------------------------Add Task using Based UrL----------------------------

  void addTask(String title, int column) async {
    if (_selectedProjectId == null || _projectOwnerName == null) {
      print("⚠️ No project selected!");
      return;
    }

    final taskId = Uuid().v4();
    String userIdentifier = await getUserIdentifier();

    final newTask = KTask(
      title: title,
      taskId: taskId,
      createdBy: _projectOwnerName!,
      createdAt: DateTime.now().toIso8601String(),
      projectId: _selectedProjectId!,
    );

    // ✅ Add task locally first
    setState(() => columns[column].children.insert(0, newTask));

    // ✅ Update task count
    setState(() {
      final index = _projects.indexWhere((p) => p.id == _selectedProjectId);
      if (index != -1) {
        _projects[index].taskCount += 1;
        _selectedProjectTaskCount = _projects[index].taskCount;
      }
    });

    // ✅ Send to backend
    final dio = Dio();
    try {
      int columnId = columns[column].id;

      // Use baseUrl here 👇
      var url = Uri.parse("${baseUrl}add_task_kanban.php");
      print("📡 Sending task to: $url");

      final response = await dio.post(
        url.toString(),
        data: {
          "title": title,
          "column_id": columnId.toString(),
          "model_name": "1",
          "project_id": _selectedProjectId.toString(),
          "created_by": _projectOwnerName!,
          "user_identifier": userIdentifier,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      final resData = response.data;
      if (resData['success'] == false) {
        print("❌ Backend error: ${resData['message']}");
      } else {
        print("✅ Task added successfully to backend");
      }
    } catch (e) {
      print("❌ Add task error: $e");
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
    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: Row(
          children: [
            // -------- Project Dropdown in AppBar----------

            SizedBox(
              width: 180,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedProjectId,
                  hint: const Text(
                    "Select Project",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  items: _projects.map((project) {
                    Color projectColor =
                        generateProjectColor(_projects.indexOf(project));
                    return DropdownMenuItem<int>(
                      value: project.id,
                      child: Row(
                        children: [
                          // -------- Folder with Task Count Badge --------
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(Icons.folder, color: projectColor, size: 18),
                              if (project.taskCount > 0)
                                Positioned(
                                  right: -6,
                                  top: -6,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor:
                                        Color.fromARGB(255, 171, 168, 168),
                                    child: Text(
                                      '${project.taskCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
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

                          // -------- Project Owner Avatar --------
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
                      final project =
                          _projects.firstWhere((p) => p.id == value);
                      _selectedProjectName = project.name;
                      _selectedProjectTaskCount = project.taskCount;
                      _projectOwnerName = project.project_owner_name;
                    });
                    getTaskData();
                  },
                ),
              ),
            ),

            //--------End Project Dropdown-----------

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

            // -------- Period Filter ----------
            GestureDetector(
              onTap: _showPeriodDialog,
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, color: Colors.green, size: 18),
                  const SizedBox(width: 2),
                  Text(
                    periodText == "1 days" ? "1d" : periodText,
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

            // -------- English date ----------
            Text(
              DateFormat("MMM dd yyyy").format(DateTime.now()),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromARGB(255, 47, 46, 46),
                fontSize: 12,
              ),
            ),

            const SizedBox(width: 6),

            // GestureDetector
          ],
        ),
      ),

      //---------End AppBar-----------

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

            // ListTile(
            //   leading: const Icon(Icons.add),
            //   title: const Text('Add Column'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     _showAddColumnDialog();
            //   },
            // ),

            ListTile(
              tileColor: Colors.grey.shade200, // 👈 light gray background
              leading: const Icon(
                Icons.add,
                color: Colors.grey, // 👈 icon color matches theme
              ),
              title: const Text(
                'Add Column',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                _showAddColumnDialog(); // Call your dialog function
              },
            ),

            // //-------------- Start About Me--------------

            // ListTile(
            //   leading: const Icon(Icons.info),
            //   title: const Text('About Me'),
            //   onTap: () {
            //     Navigator.pop(context);

            //     showDialog(
            //       context: context,
            //       barrierDismissible: true,
            //       builder: (context) {
            //         final screenSize = MediaQuery.of(context).size;
            //         final screenWidth = screenSize.width;
            //         final screenHeight = screenSize.height;

            //         // Responsive inset (~1 inch or less on small devices)
            //         final inset = screenWidth < 500 ? 32.0 : 96.0;

            //         // Control dialog height for large screens
            //         final maxDialogHeight = screenHeight < 600
            //             ? screenHeight * 0.9 // Mobile: use most of screen
            //             : screenHeight * 0.6; // Laptop: 60% height

            //         return Dialog(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           insetPadding: EdgeInsets.all(inset),
            //           child: ConstrainedBox(
            //             constraints: BoxConstraints(
            //               maxHeight: maxDialogHeight,
            //               maxWidth: screenWidth < 600
            //                   ? screenWidth * 0.9
            //                   : screenWidth * 0.5, // 50% width on desktop
            //             ),
            //             child: Stack(
            //               children: [
            //                 // Main content with image
            //                 Padding(
            //                   padding: const EdgeInsets.all(20),
            //                   child: SingleChildScrollView(
            //                     child: Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: [
            //                         // Your profile image
            //                         // const CircleAvatar(
            //                         //   radius: 50,
            //                         //   backgroundImage: AssetImage(
            //                         //       'assets/icons/muhsina.png'),
            //                         // ),
            //                         const SizedBox(height: 20),

            //                         // About Me content
            //                         const AboutMePage(),
            //                       ],
            //                     ),
            //                   ),
            //                 ),

            //                 // Close button (top right corner)
            //                 Positioned(
            //                   right: 0,
            //                   top: 0,
            //                   child: IconButton(
            //                     icon:
            //                         const Icon(Icons.close, color: Colors.grey),
            //                     iconSize: 28,
            //                     splashRadius: 20,
            //                     tooltip: 'Close',
            //                     onPressed: () => Navigator.pop(context),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),

            // End About Me

            // Backup App Icon
            // ListTile(
            //   leading: CircleAvatar(
            //     radius: 18,
            //     backgroundImage: const AssetImage('assets/icons/app_icon.png'),
            //     backgroundColor: Colors.transparent,
            //   ),
            //   title: const Text('More App'),
            //   onTap: () => Navigator.pop(context),
            // ),
            //End Backup App Icon

            // ListTile(
            //   leading: const Icon(Icons.apps),
            //   title: const Text('More App'),
            //   onTap: () => Navigator.pop(context),
            // ),

            //-------------- Start About Me--------------

//-------------- Start About Me--------------

            ListTile(
              tileColor: Colors.orange.shade50, // 👈 different light color
              leading: const Icon(
                Icons.info, // 👈 info icon for About Me
                color: Colors.orange, // 👈 matching icon color
              ),
              title: const Text(
                'About Me',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer first

                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    final screenSize = MediaQuery.of(context).size;
                    final screenWidth = screenSize.width;
                    final screenHeight = screenSize.height;

                    final inset = screenWidth < 500 ? 32.0 : 96.0;
                    final maxDialogHeight = screenHeight < 600
                        ? screenHeight * 0.9
                        : screenHeight * 0.6;

                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      insetPadding: EdgeInsets.all(inset),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: maxDialogHeight,
                          maxWidth: screenWidth < 600
                              ? screenWidth * 0.9
                              : screenWidth * 0.5,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(height: 20),
                                    AboutMePage(), // your About Me content
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.grey),
                                iconSize: 28,
                                splashRadius: 20,
                                tooltip: 'Close',
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

//-------------- End About Me--------------

            ListTile(
              tileColor: Colors.lightBlue.shade50,
              leading: const Icon(
                Icons.apps,
                color: Colors.lightBlue,
              ),
              title: const Text(
                'More App',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArabicWordListPage()),
                );
              },
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
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.folder,
                        color: projectColor,
                        size: 28,
                      ),
                      if (project.taskCount > 0)
                        Positioned(
                          right: -6,
                          top: -6,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color.fromARGB(255, 162, 163, 162),
                            child: Text(
                              '${project.taskCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    project.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Tooltip(
                    message: project.project_owner_name,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: projectColor,
                      child: Text(
                        getFirstAndLastLetter(project.project_owner_name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedProjectId = project.id;
                      _selectedProjectName = project.name;
                      _selectedProjectTaskCount =
                          project.taskCount; // 👈 update selected task count
                    });
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

  // ------------------Start Add Column ------------------
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

  // ------------------ Start Edit Task ------------------
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

  // ------------------ End Edit Task ----------------------------

// ------------------Start Delete Task from Board using baseUrl-----------------

  @override
  Future<void> deleteItem(int columnIndex, KTask task) async {
    setState(() => columns[columnIndex].children.remove(task));

    final dio = Dio();
    try {
      // ✅ Use baseUrl here
      var url = Uri.parse("${baseUrl}delete_task_kanban.php");
      print("🗑️ Delete task URL: $url");

      await dio.post(
        url.toString(),
        data: {
          "id": task.taskId,
          "deleted_by": "muhsina",
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print("✅ Task deleted successfully (ID: ${task.taskId})");
    } catch (e) {
      print("❌ Delete error: $e");
    }
  }

  // End Delete Task from Board using baseUrl

  // Start Drag and Drop with API call

  @override
  void dragHandler(KData data, int index) async {
    setState(() {
      columns[data.from].children.remove(data.task);
      columns[index].children.add(data.task);
    });

    final dio = Dio();
    try {
      // ✅ Use baseUrl just like your other API functions
      var url = Uri.parse("${baseUrl}drag_drop_kanban.php");
      print("📡 Drag-drop update URL: $url");

      await dio.post(
        url.toString(),
        data: {
          "id": data.taskId,
          "column_name": index + 1,
          "previous_status": data.from + 1,
          "model_name": 1,
          "project_name": 1,
          "status_change_by": "muhsina",
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print("✅ Drag-drop update successful");
    } catch (e) {
      print("❌ Drag error: $e");
    }
  }

  //End Drag and Drop with API call

  //Start Updated to use dynamic baseUrl

  @override
  void updateItem(int columnIndex, KTask task) async {
    final dio = Dio();

    try {
      // ✅ Use baseUrl dynamically
      var url = Uri.parse("${baseUrl}update_task_kanban.php");
      print("📡 Updating task via: $url");

      await dio.post(
        url.toString(),
        data: {
          "id": task.taskId,
          "title": task.title,
          "edited_by": "muhsina",
          "edited_at": DateTime.now().toString(),
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print("✅ Task updated successfully on backend");
    } catch (e) {
      print("❌ Update error: $e");
    }
  }

  //End Updated to use dynamic baseUrl

//Start Handle Reorder
  @override
  void handleReOrder(int oldIndex, int newIndex, int index) {
    setState(() {
      if (oldIndex != newIndex) {
        final task = columns[index].children.removeAt(oldIndex);
        columns[index].children.insert(newIndex, task);
      }
    });
  }
  //End Handle Reorder
}
