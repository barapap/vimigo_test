import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import '../models/attendance_record.dart';

class ShareButton extends StatelessWidget {
  final AttendanceRecord record;

  const ShareButton({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('dd MMM yyyy, h:mm a').format(record.time);
    return FloatingActionButton(
      onPressed: () {
        Share.share(
          'Name: ${record.name}\nContact: ${record.contact}\nTime: $formattedTime',
          subject: 'Attendee Details',
          sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 0),
        );
        if (kDebugMode) {
          print('Attendee details shared successfully');
        }
      },
      child: const Icon(Icons.share),
    );
  }
}