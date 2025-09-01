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

// Backup 25 August, 2025
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
              // color: Color.fromARGB(255, 224, 226, 226),
              color: Color.fromARGB(255, 189, 237, 190),
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

  // To Show Task as a Mini Card using Hover Tooltip
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
              // Instead of 'message', we use 'richMessage' to wrap in a container like a card
              richMessage: WidgetSpan(
                //previous 2025-08-31  backup
                // child: Container(
                //   constraints: BoxConstraints(
                //     maxWidth: 200, // 👈 max width of tooltip card
                //   ),
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     color: Colors.grey[300], // light gray
                //     borderRadius: BorderRadius.circular(6),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black26,
                //         blurRadius: 6,
                //         offset: Offset(2, 4),
                //       )
                //     ],
                //   ),
                //   child: Text(
                //     task.title,
                //     style: const TextStyle(
                //       color: Colors.black87,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),

                child: Container(
                  constraints: BoxConstraints(maxWidth: 220),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 3))
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
