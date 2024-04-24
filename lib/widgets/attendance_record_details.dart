import 'package:flutter/material.dart';
import 'package:vimigo_test/models/attendance_record.dart';

import '../utils/times_ago.dart';

class AttendanceRecordDetails extends StatelessWidget {
  static const routeName = '/attendance-record-details';

  final AttendanceRecord record;

  const AttendanceRecordDetails({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${record.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact Info: ${record.contact}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Timestamp: ${TimeAgo.format(record.time)}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}