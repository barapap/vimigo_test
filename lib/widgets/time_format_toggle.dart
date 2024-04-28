import 'package:flutter/material.dart';

import '../providers/attendance_provider.dart';

class TimeFormatToggle extends StatelessWidget {
  final AttendanceProvider aprovider;
  final bool useTimeAgoFormat;
  final Function(bool) onToggle;

  const TimeFormatToggle({super.key, required this.useTimeAgoFormat, required this.aprovider, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(useTimeAgoFormat ? Icons.access_time : Icons.calendar_today),
      onPressed: () {
        onToggle(!useTimeAgoFormat); // Call the callback function with the new value
        //Navigator.of(context).push(
          //MaterialPageRoute(
            //builder: (_) => AttendanceRecordList(provider: aprovider),
          //),
        //);
      },
    );
  }
}