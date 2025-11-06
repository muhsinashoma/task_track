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

            //-----------Start Conatiner---------------

            child: MouseRegion(
              cursor: SystemMouseCursors.click, // hover cursor
              child: Container(
                height: 120, // fixed height for consistency
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF), // soft Claude off-white tone
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ---------- Actions Button Top-Right ----------
                          Align(
                            alignment:
                                Alignment.topRight, // 👈 moved to right corner
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              color: const Color(
                                  0xFFF9F9F9), // off-white dropdown background
                              icon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "Actions",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down, size: 14),
                                ],
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
                                          color: Color.fromARGB(
                                              255, 120, 214, 184),
                                          size: 14),
                                      SizedBox(width: 6),
                                      Text('Edit',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: const [
                                      Icon(Icons.delete,
                                          color: Colors.black87, size: 14),
                                      SizedBox(width: 6),
                                      Text('Delete',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 6),

                          // ---------- Task Title ----------
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // ---------- Task Info ----------
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
                    );
                  },
                ),
              ),
            ),

            //------End Conatiner--------------
          ),
        );
      },
    );
  }
}
