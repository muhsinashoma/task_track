// import 'package:flutter/material.dart';

// import 'presentation/pages/home_page.dart';
// import 'utils/light_theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutterban',
//       theme: AppTheme.lightTheme(),
//       debugShowCheckedModeBanner: false,
//       //home: const HomePage(),
//       home: KanbanSetStatePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // <-- import this

import 'presentation/pages/home_page.dart';
import 'utils/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize locales for DateFormat
  await initializeDateFormatting('en_US', null);
  await initializeDateFormatting('bn', null);
  await initializeDateFormatting('ar', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterban',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: KanbanSetStatePage(),
    );
  }
}
