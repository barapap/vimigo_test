import 'package:flutter/material.dart';
import 'package:vimigo_test/widgets/searching_bar.dart';
import '../providers/attendance_provider.dart';
import 'add_attendance_record_dialog.dart';
import 'attendance_record_details.dart';
import 'time_format_toggle.dart';

class AttendanceRecordList extends StatefulWidget {
  final AttendanceProvider provider;

  const AttendanceRecordList({super.key, required this.provider});

  @override
  AttendanceRecordListState createState() => AttendanceRecordListState();
}

class AttendanceRecordListState extends State<AttendanceRecordList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
        actions: [
          TimeFormatToggle(
            useTimeAgoFormat: widget.provider.useTimeAgoFormat,
            aprovider: widget.provider,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchingBar(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              widget.provider.searchAttendanceRecords(_searchQuery);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.provider.fetchAttendanceRecords();
              },
              child: ListView.builder(
                itemCount: widget.provider.filteredAttendanceRecords.length,
                itemBuilder: (context, index) {
                  final record = widget.provider.filteredAttendanceRecords[index];
                  return ListTile(
                    title: Text(record.name),
                    subtitle: Text('Contact: ${record.contact}'),
                    trailing: Text(
                      widget.provider.formatTime(record.time),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AttendanceRecordDetails(record: record),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                AddAttendanceRecordDialog(provider: widget.provider),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}