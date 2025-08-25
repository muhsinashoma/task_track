import 'package:flutter/material.dart';

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
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<KTask> getFilteredTasks() {
    if (_searchText.isEmpty) return widget.column.children;
    return widget.column.children
        .where((task) =>
            task.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CardColumn(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitleColumn(),
                _buildSearchBar(),
                _buildListItemsColumn(),
                _buildButtonNewTask(widget.index),
              ],
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

  Widget _buildTitleColumn() {
    final taskCount = widget.column.children.length; // 👈 count tasks
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.column.title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 115, 221, 173),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$taskCount', // 👈 show total tasks
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Previous backup

  // Widget _buildTitleColumn() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Text(
  //       widget.column.title,
  //       style: const TextStyle(
  //         fontSize: 20,
  //         color: Colors.black,
  //         fontWeight: FontWeight.w700,
  //       ),
  //     ),
  //   );
  // }

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
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Widget _buildListItemsColumn() {
  //   final filteredTasks = getFilteredTasks();
  //   return Expanded(
  //     child: ReorderableListView(
  //       onReorder: (oldIndex, newIndex) {
  //         if (newIndex < widget.column.children.length) {
  //           widget.reorderHandler(oldIndex, newIndex, widget.index);
  //         }
  //       },
  //       children: [
  //         for (final task in filteredTasks)
  //           TaskCard(
  //             key: ValueKey(task),
  //             task: task,
  //             columnIndex: widget.index,
  //             dragListener: widget.dragListener,
  //             deleteItemHandler: widget.deleteItemHandler,
  //             updateItemHandler: widget.updateItemHandler,
  //           )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildListItemsColumn() {
  //   final filteredTasks = getFilteredTasks();
  //   return Expanded(
  //     child: ReorderableListView(
  //       onReorder: (oldIndex, newIndex) {
  //         if (newIndex < widget.column.children.length) {
  //           widget.reorderHandler(oldIndex, newIndex, widget.index);
  //         }
  //       },
  //       children: [
  //         for (final task in filteredTasks)
  //           Tooltip(
  //             key: ValueKey(
  //                 //  "${task.title}-${task.createdAt}"), // unique key from available fields
  //                 "${task.title}"),
  //             message: task.title,
  //             padding: const EdgeInsets.all(12),
  //             decoration: BoxDecoration(
  //               color: const Color.fromARGB(255, 106, 103, 103),
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 6,
  //                   offset: Offset(2, 3),
  //                 ),
  //               ],
  //             ),
  //             textStyle: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //             ),
  //             waitDuration: const Duration(milliseconds: 300),
  //             showDuration: const Duration(seconds: 3),
  //             preferBelow: false,
  //             child: TaskCard(
  //               task: task,
  //               columnIndex: widget.index,
  //               dragListener: widget.dragListener,
  //               deleteItemHandler: widget.deleteItemHandler,
  //               updateItemHandler: widget.updateItemHandler,
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

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
              key: ValueKey(task), // 👈 Add key here
              message: task.title, // only show task title
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 161, 153, 153),
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(color: Colors.white, fontSize: 13),
              waitDuration: const Duration(milliseconds: 400),
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
