import 'package:flutter/material.dart';
import '../providers/attendance_provider.dart';
import 'attendance_record_list.dart';

class StartingScreen extends StatelessWidget {
  final AttendanceProvider provider;

  const StartingScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Attendance App!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceRecordList(provider: provider),
                  ),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}