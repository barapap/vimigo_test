import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

import 'package:vimigo_test/providers/attendance_provider.dart';

class ShareButton extends StatelessWidget {
  final String text;

  const ShareButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        final attendee = Provider
            .of<AttendanceProvider>(context)
            .selectedAttendee;
        if (attendee != null) {
          FlutterShare.share(
            title: 'Attendee Details',
            text: 'Name: ${attendee.name}\nContact: ${attendee.contact}',
          );
        }
      }
    );
  }
}