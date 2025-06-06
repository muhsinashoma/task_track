import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'taks_menu.widget.dart';
import 'task_text_widget.dart';

class TaskCard extends StatelessWidget {
  final KTask task;
  final int columnIndex;
  final Function deleteItemHandler;
  final Function(DragUpdateDetails) dragListener;

  const TaskCard({
    super.key,
    required this.task,
    required this.columnIndex,
    required this.dragListener,
    required this.deleteItemHandler,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        return Container(
          height: 50,
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
                height: 50,
                width: constraints.maxWidth,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: TaskText(
                  title: task.title,
                ),
              ),
            ),
            childWhenDragging: Container(color: Colors.black12),
            data: KData(
                from: columnIndex,
                task: task,
                taskId: task.taskId), // Pass taskId here

            // child: Container(
            //   color: Colors.red,
            //   child: ListTile(
            //     dense: true,
            //     title: TaskText(
            //       title: task.title,
            //     ),
            //     trailing: InkWell(
            //       onTap: () => showModalBottomSheet(
            //         context: context,
            //         builder: (context) => TaskMenu(
            //           deleteHandler: () => deleteItemHandler(columnIndex, task),
            //         ),
            //       ),
            //       child: const Icon(
            //         color: Colors.white,
            //         Icons.more_horiz,
            //       ),
            //     ),
            //   ),
            // ),

            child: Container(
              color: Colors.red,
              child: ListTile(
                dense: true,
                title: TaskText(
                  title: task.title,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => TaskMenu(
                          deleteHandler: () =>
                              deleteItemHandler(columnIndex, task),
                        ),
                      ),
                      child: const Icon(
                          // Icons.more_horiz,
                          Icons.delete,
                          color: Colors.white,
                          size: 18),
                    ),
                    const SizedBox(width: 8), // Add some spacing between icons
                    InkWell(
                      onTap: () {
                        // Your edit handler logic here
                        print('Edit task : ${task.title}');

                        print('ID : ${task.taskId}');
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18.0,
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
