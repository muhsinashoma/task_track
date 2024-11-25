// import 'package:flutter/material.dart';

// class TaskMenu extends StatelessWidget {
//   final Function deleteHandler;
//   const TaskMenu({
//     super.key,
//     required this.deleteHandler,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double paddingBottom = MediaQuery.of(context).padding.bottom;
//     return IntrinsicHeight(
//       child: Container(
//         color: Colors.white,
//         alignment: Alignment.center,
//         padding: EdgeInsets.only(top: 30, bottom: paddingBottom + 6),
//         child: InkWell(
//           onTap: () {
//             Navigator.of(context).pop();
//             deleteHandler();
//           },
//           child: const SizedBox(
//             height: 40,
//             child: Text(
//               'Delete Task',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TaskMenu extends StatelessWidget {
  final Function deleteHandler;
  const TaskMenu({
    super.key,
    required this.deleteHandler,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, bottom: paddingBottom + 6),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            _showDeleteConfirmationDialog(context);
          },
          child: const SizedBox(
            height: 40,
            child: Text(
              'Delete Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deleteHandler(); // Call the delete handler
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
