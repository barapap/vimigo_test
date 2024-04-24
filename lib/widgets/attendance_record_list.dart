import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vimigo_test/models/attendance_record.dart';
import 'package:vimigo_test/providers/attendance_provider.dart';
import 'package:vimigo_test/utils/times_ago.dart';
import 'package:vimigo_test/widgets/share_button.dart';
import 'package:vimigo_test/widgets/time_format_toggle.dart';
import 'attendance_record_details.dart';

final _formKey = GlobalKey<FormState>();

class AttendanceRecordList extends StatefulWidget {
  static const routeName = '/attendance-record-list';
  final bool useTimeAgoFormat;
  const AttendanceRecordList({super.key, required this.useTimeAgoFormat});

  @override
  AttendanceRecordListState createState() => AttendanceRecordListState();
}

class AttendanceRecordListState extends State<AttendanceRecordList> {
  late AttendanceProvider _attendanceProvider;
  late bool _useTimeAgoFormat;
  late List<AttendanceRecord> _attendanceRecords;
  late TextEditingController _searchController;
  String? _searchQuery;

  bool get isLastItem {
    final filteredAttendanceRecords = _searchQuery == null || _searchQuery!.isEmpty
        ? _attendanceRecords
        : _attendanceRecords.where((record) => record.name.toLowerCase().contains(_searchQuery!.toLowerCase())).toList();
    final filteredAttendanceRecordsLength = filteredAttendanceRecords.length;
    return _attendanceProvider.selectedIndex == filteredAttendanceRecordsLength - 1;
  }


  @override
  void initState() {
    super.initState();
    _attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
    _useTimeAgoFormat = widget.useTimeAgoFormat;
    _attendanceRecords = _attendanceProvider.attendanceRecords;
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
    _attendanceProvider.addListener(() {
      setState(() {
        _attendanceRecords = _attendanceProvider.attendanceRecords;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredAttendanceRecords = _searchQuery == null || _searchQuery!.isEmpty
        ? _attendanceRecords
        : _attendanceRecords.where((record) => record.name.toLowerCase().contains(_searchQuery!.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
        actions: [
          TimeFormatToggle(useTimeAgoFormat: _useTimeAgoFormat),
          ShareButton(text: '${_attendanceProvider.selectedAttendee?.name}: ${_attendanceProvider.selectedAttendee?.contact}'),
        ],
      ),
      body: Column(
        children: [
          SearchBar(onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          }),
          Expanded(
            child: filteredAttendanceRecords.isNotEmpty
                ? ListView.builder(
              itemCount: filteredAttendanceRecords.length,
              itemBuilder: (context, index) {
                final record = filteredAttendanceRecords[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(record.name[0].toUpperCase()),
                  ),
                  title: Text(record.name),
                  subtitle: Text(_useTimeAgoFormat ? TimeAgo.format(record.time) : DateFormat('dd MMM yyyy, h:mm a').format(record.time)),
                  onTap: () {
                    _attendanceProvider.selectAttendee(record);
                    Navigator.pushNamed(context, AttendanceRecordDetails.routeName, arguments: record);
                  },
                );
              },
            )
                : const Center(child: Text('No attendance records yet'),),
          ),
          if (isLastItem)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('You have reached the end of the list'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Attendance Record'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Attendee Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          final record = AttendanceRecord(
                            id: DateTime.now().millisecondsSinceEpoch,
                            time: DateTime.now(),
                            name: value!,
                            contact: '',
                          );
                          _attendanceProvider.addAttendanceRecord(record);
                          _searchController.clear();
                          _searchQuery = '';
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Attendance record added'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Contact Info',
                        ),
                        onSaved: (value) {
                          final record = _attendanceProvider.attendanceRecords.last;
                          record.contact = value!;
                          _attendanceProvider.sortAttendanceRecords();
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AttendanceRecordSearchDelegate extends SearchDelegate<AttendanceRecord> {
  final List<AttendanceRecord> _attendanceRecords;

  AttendanceRecordSearchDelegate(this._attendanceRecords);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _attendanceRecords.where((record) {
      final nameLower = record.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(result.name[0].toUpperCase()),
          ),
          title: Text(result.name),
          onTap: () {
            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _attendanceRecords.where((record) {
      final nameLower = record.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(suggestion.name[0].toUpperCase()),
          ),
          title: Text(suggestion.name),
          onTap: () {
            close(context, suggestion);
          },
        );
      },
    );
  }
}