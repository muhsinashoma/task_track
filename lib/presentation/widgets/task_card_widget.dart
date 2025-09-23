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
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 70,
                width: constraints.maxWidth,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: TaskText(title: task.title),
              ),
            ),
            childWhenDragging: Container(color: Colors.black12),
            data: KData(
              from: columnIndex,
              task: task,
              taskId: task.taskId,
            ),
            child: Container(
              color: const Color.fromARGB(255, 234, 237, 237),
              child: ListTile(
                dense: true,
                title: TaskText(title: task.title),
                subtitle: Column(
                  // ✅ Added subtitle
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      "By-: ${task.createdBy}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "At-: ${task.createdAt}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        updateItemHandler(columnIndex, task);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 163, 233, 175),
                        size: 18.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => TaskMenu(
                          deleteHandler: () =>
                              deleteItemHandler(columnIndex, task),
                        ),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 125, 220, 128),
                        size: 18,
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
