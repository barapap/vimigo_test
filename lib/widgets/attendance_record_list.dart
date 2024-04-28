import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
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
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _init();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await widget.provider.fetchAttendanceRecords();
    setState(() {
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have reached the end of the list')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
        actions: [
          Consumer<AttendanceProvider>(
            builder: (context, provider, child) {
              return TimeFormatToggle(
                useTimeAgoFormat: provider.useTimeAgoFormat,
                aprovider: provider,
              );
            },
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
              child: Column(
                children: [
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Expanded(
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.forward) {
                          _onScroll();
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddAttendanceRecordDialog(
              provider: widget.provider,
              onRecordAdded: () {
                setState(() {}); // Rebuild the AttendanceRecordList widget
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}