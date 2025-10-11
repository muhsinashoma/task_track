// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart'; // <-- add this

// import '../../models/models.dart';
// import 'card_column.dart';
// import 'task_card_widget.dart';

// class KanbanColumn extends StatefulWidget {
//   final KColumn column;
//   final int index;
//   final Function dragHandler;
//   final Function reorderHandler;
//   final Function addTaskHandler;
//   final Function(DragUpdateDetails) dragListener;
//   final Function deleteItemHandler;
//   final void Function(int, KTask) updateItemHandler;

//   const KanbanColumn({
//     super.key,
//     required this.column,
//     required this.index,
//     required this.dragHandler,
//     required this.reorderHandler,
//     required this.addTaskHandler,
//     required this.dragListener,
//     required this.deleteItemHandler,
//     required this.updateItemHandler,
//   });

//   @override
//   State<KanbanColumn> createState() => _KanbanColumnState();
// }

// class _KanbanColumnState extends State<KanbanColumn> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchText = '';

//   // --- Title Editing ---
//   late TextEditingController _titleController;
//   bool _isEditing = false;
//   final Dio _dio = Dio();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         _searchText = _searchController.text;
//       });
//     });

//     _titleController = TextEditingController(text: widget.column.title);
//   }

//   @override
//   void didUpdateWidget(covariant KanbanColumn oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update text if parent updates title
//     if (oldWidget.column.title != widget.column.title) {
//       _titleController.text = widget.column.title;
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _titleController.dispose();
//     super.dispose();
//   }

//   List<KTask> getFilteredTasks() {
//     if (_searchText.isEmpty) return widget.column.children;
//     return widget.column.children
//         .where((task) =>
//             task.title.toLowerCase().contains(_searchText.toLowerCase()))
//         .toList();
//   }

// // --- Update column title function ---
//   Future<void> _updateColumnTitle(String newTitle) async {
//     if (newTitle.trim().isEmpty) return;

//     print("🔹 Attempting to update column title...");
//     print("➡️ Column ID: ${widget.column.id}");
//     print("➡️ New Title: $newTitle");

//     try {
//       final response = await _dio.post(
//         'http://192.168.0.103/API/update_column_kanban.php',
//         data: {
//           "id": widget.column.id,
//           "title": newTitle,
//           "edited_by": "muhsina",
//         },
//         options: Options(
//           headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         ),
//       );

//       print("✅ Server response received:");
//       print("Status Code: ${response.statusCode}");
//       print("Response Data: ${response.data}");

//       if (response.statusCode == 200 &&
//           response.data.toString().contains("success")) {
//         setState(() {
//           _titleController.text = newTitle;
//           _isEditing = false;
//         });
//         print("🎯 Column title updated locally to: $newTitle");
//       } else {
//         print("⚠️ Unexpected server response: ${response.data}");
//       }
//     } catch (e) {
//       print("❌ Error updating column title: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         CardColumn(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 _buildTitleColumn(),
//                 _buildSearchBar(),
//                 _buildListItemsColumn(),
//                 _buildButtonNewTask(widget.index),
//               ],
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: DragTarget<KData>(
//             onWillAccept: (data) => true,
//             onLeave: (_) {},
//             onAccept: (data) {
//               if (data.from == widget.index) return;
//               widget.dragHandler(data, widget.index);
//             },
//             builder: (context, accept, reject) => const SizedBox(),
//           ),
//         ),
//       ],
//     );
//   }

// // --- Editable Title ---
//   Widget _buildTitleColumn() {
//     final taskCount = widget.column.children.length;

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: _isEditing
//                 ? TextField(
//                     controller: _titleController,
//                     autofocus: true,
//                     onSubmitted: (value) {
//                       print("Enter pressed! New title: $value");
//                       _updateColumnTitle(value.trim());
//                     },
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                       border: OutlineInputBorder(),
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: () {
//                       print("Tapped column title!");
//                       setState(() => _isEditing = true);
//                     },
//                     child: Text(
//                       _titleController.text,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//           ),
//           IconButton(
//             icon: Icon(
//               _isEditing ? Icons.check : Icons.edit,
//               color: Colors.grey[700],
//               size: 20,
//             ),
//             onPressed: () {
//               if (_isEditing) {
//                 print(
//                     "Check icon pressed! New title: ${_titleController.text}");
//                 _updateColumnTitle(_titleController.text.trim());
//               } else {
//                 setState(() => _isEditing = true);
//               }
//             },
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 189, 237, 190),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               '$taskCount',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Search bar ---
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       child: TextField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'Search tasks...',
//           prefixIcon: const Icon(Icons.search),
//           suffixIcon: _searchText.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () => _searchController.clear(),
//                 )
//               : null,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   // --- Task list ---
//   Widget _buildListItemsColumn() {
//     final filteredTasks = getFilteredTasks();
//     return Expanded(
//       child: ReorderableListView(
//         onReorder: (oldIndex, newIndex) {
//           if (newIndex < widget.column.children.length) {
//             widget.reorderHandler(oldIndex, newIndex, widget.index);
//           }
//         },
//         children: [
//           for (final task in filteredTasks)
//             Tooltip(
//               key: ValueKey(task),
//               richMessage: WidgetSpan(
//                 child: Container(
//                   constraints: const BoxConstraints(maxWidth: 220),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         offset: Offset(2, 3),
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         task.title,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "By: ${task.createdBy}",
//                         style: const TextStyle(
//                             fontSize: 12, color: Colors.black54),
//                       ),
//                       Text(
//                         "At: ${task.createdAt}",
//                         style: const TextStyle(
//                             fontSize: 12, color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               preferBelow: false,
//               waitDuration: const Duration(milliseconds: 300),
//               child: TaskCard(
//                 task: task,
//                 columnIndex: widget.index,
//                 dragListener: widget.dragListener,
//                 deleteItemHandler: widget.deleteItemHandler,
//                 updateItemHandler: widget.updateItemHandler,
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // --- Add new task button ---
//   Widget _buildButtonNewTask(int index) {
//     return ListTile(
//       dense: true,
//       onTap: () => widget.addTaskHandler(index),
//       leading: const Icon(Icons.add_circle_outline, color: Colors.black45),
//       title: const Text(
//         'Add Task',
//         style: TextStyle(
//             fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../models/models.dart';
import 'card_column.dart';
import 'task_card_widget.dart';

class KanbanColumn extends StatefulWidget {
  final KColumn column;
  final int index;
  final Function dragHandler;
  final Function reorderHandler;
  final Function addTaskHandler;
  final Function(DragUpdateDetails) dragListener;
  final Function deleteItemHandler;
  final void Function(int, KTask) updateItemHandler;

  const KanbanColumn({
    super.key,
    required this.column,
    required this.index,
    required this.dragHandler,
    required this.reorderHandler,
    required this.addTaskHandler,
    required this.dragListener,
    required this.deleteItemHandler,
    required this.updateItemHandler,
  });

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  late TextEditingController _titleController;
  bool _isEditing = false;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
    _titleController = TextEditingController(text: widget.column.title);
  }

  @override
  void didUpdateWidget(covariant KanbanColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.column.title != widget.column.title) {
      _titleController.text = widget.column.title;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  // --- Generate unique color for each column ---
  Color generateProjectColor(int index) {
    double hue = (index * 45) % 360;
    double saturation = 0.6;
    double value = 0.85;
    return HSVColor.fromAHSV(1, hue, saturation, value).toColor();
  }

  List<KTask> getFilteredTasks() {
    if (_searchText.isEmpty) return widget.column.children;
    return widget.column.children
        .where((task) =>
            task.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  // --- Update column title function ---
  Future<void> _updateColumnTitle(String newTitle) async {
    if (newTitle.trim().isEmpty) return;

    print("🔹 Attempting to update column title...");
    print("➡️ Column ID: ${widget.column.id}");
    print("➡️ New Title: $newTitle");

    try {
      final response = await _dio.post(
        'http://192.168.0.103/API/update_column_kanban.php',
        data: {
          "id": widget.column.id,
          "title": newTitle,
          "edited_by": "muhsina",
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      print("✅ Server response received:");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 &&
          response.data.toString().contains("success")) {
        setState(() {
          _titleController.text = newTitle;
          _isEditing = false;
        });
        print("🎯 Column title updated locally to: $newTitle");
      } else {
        print("⚠️ Unexpected server response: ${response.data}");
      }
    } catch (e) {
      print("❌ Error updating column title: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color columnColor = generateProjectColor(widget.index);

    return Stack(
      children: <Widget>[
        CardColumn(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: columnColor, // 🔹 colorful top border
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitleColumn(columnColor),
                  _buildSearchBar(),
                  _buildListItemsColumn(),
                  _buildButtonNewTask(widget.index),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DragTarget<KData>(
            onWillAccept: (data) => true,
            onLeave: (_) {},
            onAccept: (data) {
              if (data.from == widget.index) return;
              widget.dragHandler(data, widget.index);
            },
            builder: (context, accept, reject) => const SizedBox(),
          ),
        ),
      ],
    );
  }

  // --- Editable Title ---
  Widget _buildTitleColumn(Color titleColor) {
    final taskCount = widget.column.children.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: _titleController,
                    autofocus: true,
                    onSubmitted: (value) {
                      print("Enter pressed! New title: $value");
                      _updateColumnTitle(value.trim());
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      border: OutlineInputBorder(),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      print("Tapped column title!");
                      setState(() => _isEditing = true);
                    },
                    child: Text(
                      _titleController.text,
                      style: TextStyle(
                        fontSize: 20,
                        color: titleColor, // 🔹 dynamic color
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
          ),
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: titleColor.withOpacity(0.8), // 🔹 colorized icon
              size: 20,
            ),
            onPressed: () {
              if (_isEditing) {
                print(
                    "Check icon pressed! New title: ${_titleController.text}");
                _updateColumnTitle(_titleController.text.trim());
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: titleColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$taskCount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: titleColor, // 🔹 count text color
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Search bar ---
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search tasks...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchText.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                )
              : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // --- Task list ---
  Widget _buildListItemsColumn() {
    final filteredTasks = getFilteredTasks();
    return Expanded(
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          if (newIndex < widget.column.children.length) {
            widget.reorderHandler(oldIndex, newIndex, widget.index);
          }
        },
        children: [
          for (final task in filteredTasks)
            Tooltip(
              key: ValueKey(task),
              richMessage: WidgetSpan(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 220),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "By: ${task.createdBy}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        "At: ${task.createdAt}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              preferBelow: false,
              waitDuration: const Duration(milliseconds: 300),
              child: TaskCard(
                task: task,
                columnIndex: widget.index,
                dragListener: widget.dragListener,
                deleteItemHandler: widget.deleteItemHandler,
                updateItemHandler: widget.updateItemHandler,
              ),
            ),
        ],
      ),
    );
  }

  // --- Add new task button ---
  Widget _buildButtonNewTask(int index) {
    return ListTile(
      dense: true,
      onTap: () => widget.addTaskHandler(index),
      leading: const Icon(Icons.add_circle_outline, color: Colors.black45),
      title: const Text(
        'Add Task',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45),
      ),
    );
  }
}
