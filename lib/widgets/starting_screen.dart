import 'package:flutter/material.dart';

import 'attendance_record_list.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});
  static const routeName = '/starting-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Attendance App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This app allows you to track attendance records with ease. Simply add a new record, and you can view the list of records sorted by time.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AttendanceRecordList.routeName);
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}