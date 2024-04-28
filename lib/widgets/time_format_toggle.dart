import 'package:flutter/material.dart';

import '../providers/attendance_provider.dart';
import 'attendance_record_list.dart';

class TimeFormatToggle extends StatelessWidget {
  final AttendanceProvider aprovider;
  final bool useTimeAgoFormat;

  const TimeFormatToggle({super.key, required this.useTimeAgoFormat, required this.aprovider});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(useTimeAgoFormat ? Icons.access_time : Icons.calendar_today),
      onPressed: () {
        aprovider.toggleTimeFormat(true);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AttendanceRecordList(provider: aprovider),
          ),
        );
      },
    );
  }
}