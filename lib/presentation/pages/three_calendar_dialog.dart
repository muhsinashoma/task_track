import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThreeCalendarDialog extends StatefulWidget {
  const ThreeCalendarDialog({super.key});

  @override
  State<ThreeCalendarDialog> createState() => _ThreeCalendarDialogState();
}

class _ThreeCalendarDialogState extends State<ThreeCalendarDialog> {
  int? _selectedProjectId;
  int _selectedProjectTaskCount = 0;
  String periodText = "1 days";

  // Dummy project list
  final _projects = [
    Project(id: 1, name: "Project A", project_owner_name: "Alice"),
    Project(id: 2, name: "Project B", project_owner_name: "Bob"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 223, 180),
        title: Row(
          children: [
            // --- Project Dropdown ---
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
                    return DropdownMenuItem<int>(
                      value: project.id,
                      child: Text(project.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProjectId = value;
                    });
                  },
                ),
              ),
            ),

            const Spacer(),

            // --- English date ---
            Text(
              DateFormat("MMM dd yyyy").format(DateTime.now()),
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),

            const SizedBox(width: 6),

            // --- Calendar Icon ---
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const ThreeCalendarDialog(),
                );
              },
              child: const Icon(
                Icons.calendar_today,
                color: Color.fromARGB(255, 5, 144, 46),
                size: 18,
              ),
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Your page content here")),
    );
  }
}

// Dummy project class
class Project {
  final int id;
  final String name;
  final String project_owner_name;

  Project(
      {required this.id, required this.name, required this.project_owner_name});
}
