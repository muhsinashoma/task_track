import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'About Me',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/icons/muhsina.jpeg'), // optional
        ),
        const SizedBox(height: 16),
        const Text(
          'Hello! I’m Muhsina Akter, Assistant Manager (Web Development Application). '
          'I’m passionate about problem-solving, team leadership, and building scalable digital solutions.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}





// import 'package:flutter/material.dart';

// class AboutMePage extends StatelessWidget {
//   const AboutMePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Me'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'About Me',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             const CircleAvatar(
//               radius: 40,
//               backgroundImage: AssetImage('assets/icons/muhsina.jpeg'),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Hello! I’m Muhsina Akter, Assistant Manager (Web Development Application). '
//               'I’m passionate about problem-solving, team leadership, and building scalable digital solutions. '
//               'Currently, I am working with a Task Management App, a School Management Web Application, '
//               'and a Quranic App will be released soon. I hold an M.Sc. degree and enjoy reading books, roof gardening, and traveling.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'I am grateful to Allah SWT who helped me develop this work. '
//               'I strive to improve my skills continuously and contribute positively to my team and organization.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
