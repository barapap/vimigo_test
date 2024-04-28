import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vimigo_test/providers/attendance_provider.dart';
import 'package:vimigo_test/widgets/starting_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartingScreen(provider: AttendanceProvider()),
    );
  }
}