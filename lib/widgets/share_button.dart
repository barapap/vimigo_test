import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../models/attendance_record.dart';

class ShareButton extends StatelessWidget {
  final AttendanceRecord record;

  const ShareButton({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Share.share(
          'Name: ${record.name}\nContact: ${record.contact}\nTime: ${record.time}',
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