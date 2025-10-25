import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'task_text_widget.dart';
import 'taks_menu.widget.dart';

class TaskCard extends StatelessWidget {
  final KTask task;
  final int columnIndex;
  final void Function(int, KTask) updateItemHandler;
  final Function deleteItemHandler;
  final Function(DragUpdateDetails) dragListener;

  const TaskCard({
    super.key,
    required this.task,
    required this.columnIndex,
    required this.updateItemHandler,
    required this.deleteItemHandler,
    required this.dragListener,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Draggable<KData>(
            onDragUpdate: dragListener,
            feedback: Material(
              color: Color.fromARGB(255, 165, 228, 181),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 70,
                width: constraints.maxWidth,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: TaskText(title: task.title),
              ),
            ),
            childWhenDragging: Container(color: Colors.white),
            data: KData(
              from: columnIndex,
              task: task,
              taskId: task.taskId,
            ),
            child: Container(
              //color: const Color.fromARGB(255, 234, 237, 237),

              color: Color.fromARGB(255, 239, 241, 239), // 👈 Claude color

              child: ListTile(
                dense: true,
                // title: TaskText(title: task.title),

                title: Text(
                  task.title, // 👈 task title
                  style: const TextStyle(
                    fontSize: 10, // 👈 set font size 10 px
                    fontWeight: FontWeight.w500, // optional
                  ),
                ),

                subtitle: Column(
                  // ✅ Added subtitle
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      "By-: ${task.createdBy}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "At-: ${task.createdAt}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                trailing: PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      updateItemHandler(columnIndex, task);
                    } else if (value == 'delete') {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => TaskMenu(
                          deleteHandler: () =>
                              deleteItemHandler(columnIndex, task),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: const [
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 120, 214, 184),
                              size: 14),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.redAccent, size: 14),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
