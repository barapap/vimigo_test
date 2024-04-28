import 'package:flutter/material.dart';
import 'package:vimigo_test/providers/attendance_provider.dart';
import 'package:vimigo_test/widgets/starting_screen.dart';


void main() {
  runApp(const MyApp());
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